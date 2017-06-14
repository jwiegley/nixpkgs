{ stdenv
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
, numpy
, six
, scipy
, nose
, nose-parameterized
, pydot_ng
, sphinx
, pygments
, future
, cudaSupport ? false
, cudatoolkit ? null
, pycuda ? null
, libgpuarray ? null
, cudnn ? null
}:

assert cudaSupport
  -> cudatoolkit != null
  && pycuda != null
  && libgpuarray != null
  && cudnn != null;

buildPythonPackage rec {
  name = "Theano-${stdenv.lib.optionalString cudaSupport "cuda-"}${version}";
  version = "0.8.2";

  src = fetchFromGitHub {
    owner = "Theano";
    repo = "Theano";
    rev = "46fbfeb628220b5e42bf8277a5955c52d153e874";
    sha256 = "1sl91gli3jaw5gpjqqab4fiq4x6282spqciaid1s65pjsf3k55sc";
  };

  doCheck = false;

  patchPhase = stdenv.lib.optionalString (pythonOlder "3.0") ''
    pushd theano/sandbox/gpuarray
    sed -i -re '2s/^/from builtins import bytes\n/g' subtensor.py
    sed -i -re "s/(b'2')/int(bytes(\1))/g" subtensor.py
    sed -i -re "s/(ctx.bin_id\[\-2\])/int(\1)/g" subtensor.py

    sed -i -re '2s/^/from builtins import bytes\n/g' dnn.py
    sed -i -re "s/(b'30')/int(bytes(\1))/g" dnn.py
    sed -i -re "s/(ctx.bin_id\[\-2:\])/int(\1)/g" dnn.py
    popd
  '';

  dontStrip = true;

  propagatedBuildInputs = [
    numpy.blas
    numpy
    six
    scipy
    nose
    nose-parameterized
    pydot_ng
    sphinx
    pygments
  ] ++ stdenv.lib.optionals cudaSupport [
    cudatoolkit
    pycuda
    libgpuarray
    cudnn
  ] ++ stdenv.lib.optional (pythonOlder "3.0") future;

  passthru = { inherit cudaSupport; };
}
