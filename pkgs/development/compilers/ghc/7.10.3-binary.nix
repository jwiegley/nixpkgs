{ stdenv
, fetchurl, perl
, ncurses5, gmp, libiconv
, gcc, llvm_35
}:

# Prebuilt only does native
assert stdenv.targetPlatform == stdenv.hostPlatform;

let
  libPath = stdenv.lib.makeLibraryPath ([
    ncurses5 gmp
  ] ++ stdenv.lib.optional (stdenv.hostPlatform.isDarwin) libiconv);

  libEnvVar = stdenv.lib.optionalString stdenv.hostPlatform.isDarwin "DY"
    + "LD_LIBRARY_PATH";

in

stdenv.mkDerivation rec {
  version = "7.10.3";

  name = "ghc-${version}-binary";

  src = fetchurl ({
    "i686-linux" = {
      url = "http://haskell.org/ghc/dist/${version}/ghc-${version}b-i386-deb7-linux.tar.bz2";
      sha256 = "20b32912fb7e57910a3c908f99a9519b57a4872e1ea0f4f2265b2f7b30e8a3cd";
    };
    "x86_64-linux" = {
      url = "http://haskell.org/ghc/dist/${version}/ghc-${version}b-x86_64-deb8-linux.tar.bz2";
      sha256 = "5e163c557e9236cce68be41c984eab0fcdbdc1602e39040ca9ae325e6bdec1c3";
    };
    "armv7l-linux" = {
      url = "http://haskell.org/ghc/dist/${version}/ghc-${version}-armv7-deb8-linux.tar.bz2";
      sha256 = "2913763eef88e4d1843a1e4c34225afb1866310d1a1956c08a4131f4593518f6";
    };
    "x86_64-darwin" = {
      url = "http://haskell.org/ghc/dist/${version}/ghc-${version}b-x86_64-apple-darwin.tar.bz2";
      sha256 = "4b537228d49b5ea0f8e8dbcc440a5b3c3cb19a92579d607291cc0041422fa5c3";
    };
  }.${stdenv.hostPlatform.system}
    or (throw "cannot bootstrap GHC on this platform"));

  nativeBuildInputs = [ perl ];
  buildInputs = stdenv.lib.optionals stdenv.targetPlatform.isArm [ llvm_35 ];

  # Cannot patchelf beforehand due to relative RPATHs that anticipate
  # the final install location/
  ${libEnvVar} = libPath;

  postUnpack =
    # GHC has dtrace probes, which causes ld to try to open /usr/lib/libdtrace.dylib
    # during linking
    stdenv.lib.optionalString stdenv.isDarwin ''
      export NIX_LDFLAGS+=" -no_dtrace_dof"
      # not enough room in the object files for the full path to libiconv :(
      for exe in $(find . -type f -executable); do
        isScript $exe && continue
        ln -fs ${libiconv}/lib/libiconv.dylib $(dirname $exe)/libiconv.dylib
        install_name_tool -change /usr/lib/libiconv.2.dylib @executable_path/libiconv.dylib -change /usr/local/lib/gcc/5/libgcc_s.1.dylib ${gcc.cc.lib}/lib/libgcc_s.1.dylib $exe
      done
    '' +

    # Some scripts used during the build need to have their shebangs patched
    ''
      patchShebangs ghc-${version}/utils/
    '' +

    # Strip is harmful, see also below. It's important that this happens
    # first. The GHC Cabal build system makes use of strip by default and
    # has hardcoded paths to /usr/bin/strip in many places. We replace
    # those below, making them point to our dummy script.
    ''
      mkdir "$TMP/bin"
      for i in strip; do
        echo '#! ${stdenv.shell}' > "$TMP/bin/$i"
        chmod +x "$TMP/bin/$i"
      done
      PATH="$TMP/bin:$PATH"
    '' +
    # We have to patch the GMP paths for the integer-gmp package.
    ''
      find . -name integer-gmp.buildinfo \
          -exec sed -i "s@extra-lib-dirs: @extra-lib-dirs: ${gmp.out}/lib@" {} \;
    '' + stdenv.lib.optionalString stdenv.isDarwin ''
      find . -name base.buildinfo \
          -exec sed -i "s@extra-lib-dirs: @extra-lib-dirs: ${libiconv}/lib@" {} \;
    '' +
    # Rename needed libraries and binaries, fix interpreter
    stdenv.lib.optionalString stdenv.isLinux ''
      find . -type f -perm -0100 -exec patchelf \
          --replace-needed libncurses${stdenv.lib.optionalString stdenv.is64bit "w"}.so.5 libncurses.so \
          --replace-needed libtinfo.so libtinfo.so.5 \
          --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" {} \;

      paxmark m ./ghc-${version}/ghc/stage2/build/tmp/ghc-stage2

      sed -i "s|/usr/bin/perl|perl\x00        |" ghc-${version}/ghc/stage2/build/tmp/ghc-stage2
      sed -i "s|/usr/bin/gcc|gcc\x00        |" ghc-${version}/ghc/stage2/build/tmp/ghc-stage2
    '';

  configurePlatforms = [ ];
  configureFlags = [
    "--with-gmp-libraries=${stdenv.lib.getLib gmp}/lib"
    "--with-gmp-includes=${stdenv.lib.getDev gmp}/include"
  ] ++ stdenv.lib.optional stdenv.isDarwin "--with-gcc=${./gcc-clang-wrapper.sh}";

  # Stripping combined with patchelf breaks the executables (they die
  # with a segfault or the kernel even refuses the execve). (NIXPKGS-85)
  dontStrip = true;

  # No building is necessary, but calling make without flags ironically
  # calls install-strip ...
  dontBuild = true;

  # On Linux, use patchelf to modify the executables so that they can
  # find editline/gmp.
  preFixup = stdenv.lib.optionalString stdenv.isLinux ''
    for p in $(find "$out" -type f -executable); do
      if isELF "$p"; then
        echo "Patchelfing $p"
        patchelf --set-rpath "${libPath}:$(patchelf --print-rpath $p)" $p
      fi
    done
  '' + stdenv.lib.optionalString stdenv.isDarwin ''
    # not enough room in the object files for the full path to libiconv :(
    for exe in $(find "$out" -type f -executable); do
      isScript $exe && continue
      ln -fs ${libiconv}/lib/libiconv.dylib $(dirname $exe)/libiconv.dylib
      install_name_tool -change /usr/lib/libiconv.2.dylib @executable_path/libiconv.dylib -change /usr/local/lib/gcc/5/libgcc_s.1.dylib ${gcc.cc.lib}/lib/libgcc_s.1.dylib $exe
    done

    for file in $(find "$out" -name setup-config); do
      substituteInPlace $file --replace /usr/bin/ranlib "$(type -P ranlib)"
    done
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    unset ${libEnvVar}
    # Sanity check, can ghc create executables?
    cd $TMP
    mkdir test-ghc; cd test-ghc
    cat > main.hs << EOF
      {-# LANGUAGE TemplateHaskell #-}
      module Main where
      main = putStrLn \$([|"yes"|])
    EOF
    $out/bin/ghc --make main.hs || exit 1
    echo compilation ok
    [ $(./main) == "yes" ]
  '';

  passthru = { targetPrefix = ""; };

  meta.license = stdenv.lib.licenses.bsd3;
  meta.platforms = ["x86_64-linux" "i686-linux" "x86_64-darwin" "armv7l-linux"];
}
