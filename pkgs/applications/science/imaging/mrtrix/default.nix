{ stdenv
, fetchFromGitHub
, python2Packages
, eigen
, mesa
, qmake
, qtscript
, qtsvg
, x11
, zlib
}:

stdenv.mkDerivation rec {
  name = "MRtrix3-${version}";
  version = "0.3.16";

  src = fetchFromGitHub {
    owner = "MRtrix3";
    repo = "mrtrix3";
    rev = "${version}";
    sha256 = "1h2r1i6qs09cpb476cqwk5fcq7q2g4cqrzadavvf3bz66dr81ir8";
  };

  nativeBuildInputs = [
    qmake
  ];
  buildInputs = [
    python2Packages.python
    python2Packages.numpy
    eigen
    mesa
    qtscript
    qtsvg
    x11
    zlib
  ];

  EIGEN_CFLAGS = "-isystem ${eigen}/include/eigen3";
  dontAddPrefix = true;
  enableParallelBuilding = true;
  # We need qmake, but don't actually use qmakeConfigurePhase
  configurePhase = ''
    runHook preConfigure
    patchShebangs .
    LD=$CXX ./configure
  '';
  buildPhase = ''
    if [ -z "$enableParallelBuilding" ]; then
      export NUMBER_OF_PROCESSORS="1"
    else
      export NUMBER_OF_PROCESSORS="$NIX_BUILD_CORES"
    fi
    ./build
  '';
  installPhase = ''
    mkdir -p $out
    mv release/{bin,lib} $out
  '';

  meta = with stdenv.lib; {
    description = "Advanced tools for the analysis of diffusion MRI data";
    longDescription = ''
      MRtrix3 provides a set of tools to perform various types of diffusion
      MRI analyses, from various forms of tractography through to
      next-generation group-level analyses.
    '';
    homepage = http://www.mrtrix.org/;
    license = licenses.mpl20;
    maintainers = [ maintainers.ashgillman ];
    platforms = platforms.all;
  };
}
