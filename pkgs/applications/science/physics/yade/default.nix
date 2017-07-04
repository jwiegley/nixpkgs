{ stdenv, fetchurl, fetchFromGitHub, pkgconfig, cmake, makeWrapper, python27Packages,
boost, cgal, loki, pythonFull, eigen3_3, bzip2, zlib, openblas, vtk, gmp, gts, metis,
mpfr, suitesparse, glib, pcre } :

let 

  pythonPackages = python27Packages;

    minieigen = pythonPackages.buildPythonPackage rec {
      name = "minieigen";

      src = fetchFromGitHub {
        owner = "eudoxos";
        repo = "minieigen";
        rev = "7bd0a2e823333477a2172b428a3801d9cae0800f";
        sha256 = "1jksrbbcxshxx8iqpxkc1y0v091hwji9xvz9w963gjpan4jf61wj";
        };

      buildInputs = [ unzip pythonPackages.boost boost eigen3_3 ];

      patchPhase = ''
        sed -i "s/^.*libraries=libraries.//g" setup.py 
      '';

      preConfigure = ''
        export LDFLAGS="-L${eigen3_3}/lib -l boost_python"
        export CFLAGS="-I${eigen3_3}/include/eigen3"
      '';

    };

in 


  stdenv.mkDerivation rec {

    name = "yade-${version}";
    version = "2017.01a";

    meta = {
      description = "An extensible open-source framework for discrete numerical models, focused on Discrete Element Method";
      license     = stdenv.lib.licenses.gpl2;
      homepage    = https://www.yade-dem.org/;
      platforms   = stdenv.lib.platforms.unix;
      maintainers = with stdenv.lib.maintainers; [ remche ];
    };

    nativeBuildInputs = [
      pkgconfig
      cmake
      makeWrapper
      python2Packages.wrapPython
    ];

    buildInputs = [ 
      boost
      cgal
      loki
      python27Full
      python27Packages.numpy
      eigen3_3
      bzip2
      zlib
      openblas
      vtk
      gmp
      gts
      metis
      mpfr
      suitesparse
      glib
      pcre
      minieigen
    ];

    pythonPath = with pythonPackages; [
      pygments
      pexpect
      decorator
      numpy
      ipython
      ipython_genutils
      traitlets
      enum
      six
      boost
      minieigen
      pillow
      matplotlib
    ];

    src = fetchurl
    {
      url = "https://launchpad.net/yade/trunk/yade-1.00.0/+download/yade-2017.01a.tar.gz";
      sha512 = "0133afa759a6061db99b2e0f4b1081122fc6ddda13a0163389ec2f51c95e658dc148ffd43d19d908c7bfb6af2f01d1f614c1f3bba411fbf5b289898a5dd284a9";
    };

    patches = [ ./cmake.patch ];

    postInstall = ''
      wrapPythonPrograms
    '';

    enableParallelBuilding = true;

    cmakeFlags = [ "-DCMAKE_INSTALL_PREFIX=$out -DENABLE_GUI=OFF -DSUFFIX=-${version}" ];

  }



