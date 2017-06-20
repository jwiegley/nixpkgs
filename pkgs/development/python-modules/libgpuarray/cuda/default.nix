{ stdenv 
, buildPythonPackage
, fetchFromGitHub
, cmake
, cython
, numpy
, Mako
, six
, nose
, beaker
, memcached
, pkgconfig
, glibc
, clblas
, Babel
, pygments
, scipy
, python
, cudatoolkit
, nvidia_x11
}: 
buildPythonPackage rec {
  name = "libgpuarray-cuda-${version}";
  version = "0.6.5";

  src = fetchFromGitHub {
    owner = "Theano"; 
    repo = "libgpuarray";
    rev = "v${version}";
    sha256 = "1kamwn01063ak3g27xiazvd3c2ci55b11irwgn35d129yq5mgxjw";
  }; 

  doCheck = true;

  configurePhase = ''
    mkdir -p Build/Install
    pushd Build

    cmake .. -DCMAKE_BUILD_TYPE=Release \
             -DCMAKE_INSTALL_PREFIX=./Install \
             -DCLBLAS_ROOT_DIR=${clblas}

    popd
  ''; 

  preBuild = ''
    pushd Build
    make 
    make install
    popd
  ''; 

  setupPyBuildFlags = [ "-L $(pwd)/Build/Install/lib" "-I $(pwd)/Build/Install/include" ];

  preInstall = ''
    cp -r Build/Install $out
  '';

  postInstall = ''
    pushd $out/${python.sitePackages}/pygpu
    for f in $(find $out/pygpu -name "*.h"); do
      ln -s $f $(basename $f)
    done
    popd
  ''; 
  checkPhase = ''
    mkdir -p my_bin
    pushd my_bin

    cat > libgpuarray_run_tests << EOF
#!/bin/sh
if [ \$# -eq 0 ]; then 
  echo "No argument provided."
  echo "Available tests:"
  ls $out/${python.sitePackages}/pygpu/tests | grep "test_"
  exit 1
else
  nosetests -v "$out/${python.sitePackages}/pygpu/tests/\$@"
fi
EOF

    chmod +x libgpuarray_run_tests
    popd

    cp -r my_bin $out/bin
  '';

  postFixup = ''
    function fixRunPath {
      p=$(patchelf --print-rpath $1)
      patchelf --set-rpath "$p:${stdenv.lib.makeLibraryPath [ cudatoolkit clblas nvidia_x11 ]}" $1
    }

    fixRunPath $out/lib/libgpuarray.so
  '';

  dontStrip = true; 

  propagatedBuildInputs = [
    numpy
    scipy
    nose
    six
    Mako
  ];

  buildInputs = [ 
    cmake 
    cython 
    beaker 
    memcached 
    pkgconfig 
    glibc 
    Babel 
    pygments 
    numpy.blas 
    cudatoolkit
    nvidia_x11
    clblas
  ]; 

  meta = with stdenv.lib; {
    homepage = https://github.com/Theano/libgpuarray;
    description = "Library to manipulate tensors on GPU.";
    license = licenses.free;
    maintainers = with maintainers; [ artuuge ];
    platforms = platforms.linux;
  };

}
