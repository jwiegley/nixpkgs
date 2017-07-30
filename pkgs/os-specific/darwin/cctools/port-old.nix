{ stdenv, fetchFromGitHub, makeWrapper, autoconf, automake, libtool_2
, llvm, libcxx, libcxxabi, clang, libuuid
, libobjc ? null, maloader ? null, xctoolchain ? null
, buildPlatform, hostPlatform, targetPlatform
}:

let
  prefix = stdenv.lib.optionalString
    (targetPlatform != hostPlatform)
    "${targetPlatform.config}-";
in

assert targetPlatform.isDarwin;

# Non-Darwin alternatives
assert (!hostPlatform.isDarwin) -> (maloader != null && xctoolchain != null);

let
  baseParams = rec {
    name = "cctools-port-${version}";
    version = "886";

    src = fetchFromGitHub {
      owner  = "tpoechtrager";
      repo   = "cctools-port";
      rev    = "02f0b8ecd87a3951653d838a321ae744815e21a5";
      sha256 = "0bzyabzr5dvbxglr74d0kbrk2ij5x7s5qcamqi1v546q1had1wz1";
    };

    buildInputs = [ autoconf automake libtool_2 libuuid ] ++
      # Only need llvm and clang if the stdenv isn't already clang-based (TODO: just make a stdenv.cc.isClang)
      stdenv.lib.optionals (!stdenv.isDarwin) [ llvm clang ] ++
      stdenv.lib.optionals stdenv.isDarwin [ libcxxabi libobjc ];

    patches = [
      ./ld-rpath-nonfinal.patch ./ld-ignore-rpath-link.patch
    ] ++ stdenv.lib.optionals stdenv.isDarwin [
      # See https://github.com/tpoechtrager/cctools-port/issues/24. Remove when that's fixed.
      ./undo-unknown-triple.patch
      ./ld-tbd-v2.patch
    ];

    enableParallelBuilding = true;

    configureFlags = stdenv.lib.optionals (!stdenv.isDarwin) [
      "CXXFLAGS=-I${libcxx}/include/c++/v1"
    ] ++ stdenv.lib.optionals (targetPlatform != buildPlatform) [
      # TODO make unconditional next hash break
      "--build=${buildPlatform.config}"
      "--host=${hostPlatform.config}"
      "--target=${targetPlatform.config}"
    ];

    postPatch = ''
      sed -i -e 's/addStandardLibraryDirectories = true/addStandardLibraryDirectories = false/' cctools/ld64/src/ld/Options.cpp

      # FIXME: there are far more absolute path references that I don't want to fix right now
      substituteInPlace cctools/configure.ac \
        --replace "-isystem /usr/local/include -isystem /usr/pkg/include" "" \
        --replace "-L/usr/local/lib" "" \

      substituteInPlace cctools/include/Makefile \
        --replace "/bin/" ""

      patchShebangs tools
      sed -i -e 's/which/type -P/' tools/*.sh

      # Workaround for https://www.sourceware.org/bugzilla/show_bug.cgi?id=11157
      cat > cctools/include/unistd.h <<EOF
      #ifdef __block
      #  undef __block
      #  include_next "unistd.h"
      #  define __block __attribute__((__blocks__(byref)))
      #else
      #  include_next "unistd.h"
      #endif
      EOF
    '' + stdenv.lib.optionalString (!stdenv.isDarwin) ''
      sed -i -e 's|clang++|& -I${libcxx}/include/c++/v1|' cctools/autogen.sh
    '';

    # TODO: this builds an ld without support for LLVM's LTO. We need to teach it, but that's rather
    # hairy to handle during bootstrap. Perhaps it could be optional?
    preConfigure = ''
      cd cctools
      sh autogen.sh
    '';

    preInstall = ''
      pushd include
      make DSTROOT=$out/include RC_OS=common install
      popd
    '';

    postInstall =
      if hostPlatform.isDarwin
      then ''
        cat >$out/bin/dsymutil << EOF
        #!${stdenv.shell}
        EOF
        chmod +x $out/bin/dsymutil
      ''
      else ''
        for tool in dyldinfo dwarfdump dsymutil; do
          ${makeWrapper}/bin/makeWrapper "${maloader}/bin/ld-mac" "$out/bin/${targetPlatform.config}-$tool" \
            --add-flags "${xctoolchain}/bin/$tool"
          ln -s "$out/bin/${targetPlatform.config}-$tool" "$out/bin/$tool"
        done
      '';

    meta = {
      homepage = "http://www.opensource.apple.com/source/cctools/";
      description = "Mac OS X Compiler Tools (cross-platform port)";
      license = stdenv.lib.licenses.apsl20;
    };
  };
in stdenv.mkDerivation baseParams
