{ stdenv, lib, fetchgit, bootPkgs, perl, ncurses, libiconv, targetPackages, coreutils
, autoconf, automake, happy, alex, python3, buildPlatform, targetPlatform
, selfPkgs, cross ? null

  # If enabled GHC will be build with the GPL-free but slower integer-simple
  # library instead of the faster but GPLed integer-gmp library.
, enableIntegerSimple ? false, gmp
  # Whether or not to build shipped libraries with position independent code.
, enableBootLibPIC ? false
, version ? "8.3.20170808"
}:

let
  inherit (bootPkgs) ghc;

  commonBuildInputs = [ ghc perl autoconf automake happy alex python3 ];

  rev = "14457cf6a50f708eecece8f286f08687791d51f7";

  picConfigString = ''
    GhcRtsHcOpts += -fPIC
    libraries/array_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/base_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/binary_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/bytestring_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/Cabal_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/containers_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/deepseq_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/directory_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/dph_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/filepath_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/ghc-boot_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/ghc-boot-th_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/ghc-compact_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/ghc-prim_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/haskeline_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/hpc_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/integer-gmp_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/mtl_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/parallel_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/parsec_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/pretty_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/primitive_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/process_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/random_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/stm_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/template-haskell_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/terminfo_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/text_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/time_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/transformers_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/unix_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/vector_dist-install_EXTRA_HC_OPTS += -fPIC
    libraries/xhtml_dist-install_EXTRA_HC_OPTS += -fPIC
  '' + ( if enableIntegerSimple
         then "libraries/integer-simple_dist-install_EXTRA_HC_OPTS += -fPIC"
         else "libraries/integer-gmp_dist-install_EXTRA_HC_OPTS += -fPIC"
       );

  commonPreConfigure =  ''
    echo ${version} >VERSION
    echo ${rev} >GIT_COMMIT_ID
    ./boot
    sed -i -e 's|-isysroot /Developer/SDKs/MacOSX10.5.sdk||' configure
  '' + stdenv.lib.optionalString (!stdenv.isDarwin) ''
    export NIX_LDFLAGS="$NIX_LDFLAGS -rpath $out/lib/ghc-${version}"
  '' + stdenv.lib.optionalString stdenv.isDarwin ''
    export NIX_LDFLAGS+=" -no_dtrace_dof"
  '' + stdenv.lib.optionalString enableIntegerSimple ''
    echo "INTEGER_LIBRARY=integer-simple" > mk/build.mk
  '' + stdenv.lib.optionalString  enableBootLibPIC ''
      echo "${picConfigString}" >> mk/build.mk
  '';

in stdenv.mkDerivation (rec {
  inherit version rev;
  name = "ghc-${version}";

  src = fetchgit {
    url = "git://git.haskell.org/ghc.git";
    inherit rev;
    sha256 = "08vj9ca7rq7rv8pjfl14fg2lg9d6zisrwlq6bi5vzr006816dy8y";
  };

  postPatch = "patchShebangs .";

  preConfigure = commonPreConfigure;

  buildInputs = commonBuildInputs;

  enableParallelBuilding = true;

  configureFlags = [
    "CC=${stdenv.cc}/bin/cc"
    "--with-curses-includes=${ncurses.dev}/include" "--with-curses-libraries=${ncurses.out}/lib"
    "--datadir=$doc/share/doc/ghc"
  ] ++ stdenv.lib.optional (! enableIntegerSimple) [
    "--with-gmp-includes=${gmp.dev}/include" "--with-gmp-libraries=${gmp.out}/lib"
  ] ++ stdenv.lib.optional stdenv.isDarwin [
    "--with-iconv-includes=${libiconv}/include" "--with-iconv-libraries=${libiconv}/lib"
  ];

  # required, because otherwise all symbols from HSffi.o are stripped, and
  # that in turn causes GHCi to abort
  stripDebugFlags = [ "-S" ] ++ stdenv.lib.optional (!stdenv.isDarwin) "--keep-file-symbols";

  checkTarget = "test";

  postInstall = ''
    paxmark m $out/lib/${name}/bin/{ghc,haddock}

    # Install the bash completion file.
    install -D -m 444 utils/completion/ghc.bash $out/share/bash-completion/completions/ghc

    # Patch scripts to include "readelf" and "cat" in $PATH.
    for i in "$out/bin/"*; do
      test ! -h $i || continue
      egrep --quiet '^#!' <(head -n 1 $i) || continue
      sed -i -e '2i export PATH="$PATH:${stdenv.lib.makeBinPath [ targetPackages.stdenv.cc.bintools coreutils ]}"' $i
    done
  '';

  outputs = [ "out" "doc" ];

  passthru = {
    inherit bootPkgs;
  } // stdenv.lib.optionalAttrs (targetPlatform != buildPlatform) {
    crossCompiler = selfPkgs.ghc.override {
      cross = targetPlatform;
      bootPkgs = selfPkgs;
    };
  };

  meta = {
    homepage = http://haskell.org/ghc;
    description = "The Glasgow Haskell Compiler";
    maintainers = with stdenv.lib.maintainers; [ marcweber andres peti ];
    inherit (ghc.meta) license platforms;
  };

} // stdenv.lib.optionalAttrs (cross != null) {
  name = "${cross.config}-ghc-${version}";

  preConfigure = commonPreConfigure + ''
    sed 's|#BuildFlavour  = quick-cross|BuildFlavour  = perf-cross|' mk/build.mk.sample > mk/build.mk
  '';

  configureFlags = [
    "CC=${stdenv.cc}/bin/${cross.config}-cc"
    "LD=${stdenv.cc}/bin/${cross.config}-ld"
    "AR=${stdenv.cc}/bin/${cross.config}-ar"
    "NM=${stdenv.cc}/bin/${cross.config}-nm"
    "RANLIB=${stdenv.cc}/bin/${cross.config}-ranlib"
    "--target=${cross.config}"
    "--enable-bootstrap-with-devel-snapshot"
  ] ++
    # fix for iOS: https://www.reddit.com/r/haskell/comments/4ttdz1/building_an_osxi386_to_iosarm64_cross_compiler/d5qvd67/
    lib.optional (cross.config or null == "aarch64-apple-darwin14") "--disable-large-address-space";

  buildInputs = commonBuildInputs;

  configurePlatforms = [];

  passthru = {
    inherit bootPkgs cross;

    cc = "${stdenv.cc}/bin/${cross.config}-cc";

    ld = "${stdenv.cc}/bin/${cross.config}-ld";
  };
})
