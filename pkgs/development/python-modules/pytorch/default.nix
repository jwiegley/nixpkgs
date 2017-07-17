{ buildPythonPackage, fetchFromGitHub, lib, numpy, pyyaml, cffi, cmake,
  gcc, git, openblas, stdenv }:
buildPythonPackage rec {
  version = "v0.1.12";
  name = "pytorch-${version}";

  src = fetchFromGitHub {
    owner = "pytorch";
    repo = "pytorch";
    rev = version;
    sha256 = "0r8mf4xya76gz83y5z3hfxh0rydkydafhipl8g7d0bfrgw961jy9";
  };

  checkPhase = ''
    ${stdenv.shell} test/run_test.sh
  '';

  buildInputs = [
     cmake
     git
     numpy.blas
  ];
  
  propagatedBuildInputs = [
    cffi
    numpy
    pyyaml
  ];

  preConfigure = ''
    export NO_CUDA=1
  '';
  
  meta = {
    description = "Tensors and Dynamic neural networks in Python with strong GPU acceleration.";
    homepage = http://pytorch.org/;
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ teh ];
  };
}
