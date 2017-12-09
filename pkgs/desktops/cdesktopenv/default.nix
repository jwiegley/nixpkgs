{ stdenv, fetchurl, fetchFromGitHub, symlinkJoin, callPackage
, bdftopcf, mkfontdir, xset, xrdb
, bison, ncompress, motif, xproto, xbitmaps, libjpeg, libX11, libXt, libXext
, libXft, libXinerama, libXmu, libXdmcp, libXScrnSaver, libXaw
, gcc, perl, gnum4, glibcLocales }:

let
  version = "2.2.4";

  ksh = callPackage ./ksh.nix {};
  x11ProjectRoot = symlinkJoin {
    name = "x11ProjectRoot";
    paths = [
      bdftopcf mkfontdir
      xset xrdb
    ];
  };
  patchInterpreters = [
    ksh
  ];
in stdenv.mkDerivation {
  name = "CDE-${version}";

  src = fetchurl {
    url = "mirror://sourceforge/cdesktopenv/src/cde-src-${version}.tar.gz";
    sha256 = "0zm6vkiwjb9g8sbcyd6pljjcrk2y50kgxa0jp5mvjgr6hr68lzam";
  };
  #src = fetchFromGitHub {
  #  owner = "gnidorah";
  #  repo = "cde";
  #  rev = "2e0db98c0f84c00db29ec42c866ae330a8d90dce";
  #  sha256 = "1d9645b97fi2l4v4iwlsa53bww20g0j3ldam90af3javw463jpby";
  #};

  patches = [
    ./patches/0001-Remove-some-hardcoded-pathes.patch
    ./patches/0002-Allow-overriding-of-m4-for-Linux-and-BSD.patch
  ];

  buildInputs = [
    bison ncompress motif xproto xbitmaps libjpeg libX11 libXt libXext
    libXft libXinerama libXmu libXdmcp libXScrnSaver libXaw
  ] ++ patchInterpreters;

  hardeningDisable = [ "format" ];

  postUnpack = ''
    ln -s `pwd`/cde-${version} `pwd`/cde-${version}/cde
  '';

  buildPhase = ''
    cd cde

    cat >> config/cf/site.def << EOF
#define MakeFlagsToShellFlags(makeflags,shellcmd) set -e
#define KornShell ${ksh}/bin/ksh
#define CppCmd ${gcc}/bin/cpp
#define PerlCmd ${perl}/bin/perl
#define M4Cmd ${gnum4}/bin/m4
#define X11ProjectRoot ${x11ProjectRoot}
#define CdeInstallationTop $out/opt/dt/usr
#define CdeLogFilesTop $out/opt/dt/var
#define CdeConfigurationTop $out/opt/dt/etc
EOF

    patchShebangs .

    export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
    export IMAKECPP=cpp
    make -j1 World BOOTSTRAPCFLAGS="-I${xproto}/include/X11"
  '';

  installPhase = ''
    for i in databases/*.{udb,src}
    do
      substituteInPlace $i \
        --replace /usr/dt/ $out/opt/dt/usr/
    done

    export INSTALL_LOCATION=$out/opt/dt/usr
    export LOGFILES_LOCATION=$out/opt/dt/var
    export CONFIGURE_LOCATION=$out/opt/dt/etc
    admin/IntegTools/dbTools/installCDE -s . -DontRunScripts
  '';
}
