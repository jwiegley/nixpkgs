{ stdenv
, runCommandCC
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
, gcc49 ? null
, pycuda ? null
, libgpuarray ? null
, cudnn ? null
}:

assert cudaSupport
  -> cudatoolkit != null
  && gcc49 != null
  && pycuda != null
  && libgpuarray != null
  && cudnn != null;

buildPythonPackage rec {
  name = "Theano-${stdenv.lib.optionalString cudaSupport "cuda-"}${version}";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "Theano";
    repo = "Theano";
    rev = "rel-${version}";
    sha256 = "1smnbp7gyap2wjbqv6rirvzqspy6236ax8svf1igjb6hfh5zn5zs";
  };

  doCheck = false;

  patches = [
    ./paths.patch
  ] ++ stdenv.lib.optionals cudaSupport [
    ./paths-cuda.patch
    ./memcpy.patch
  ];
  postPatch =
    let
      # Closure for running a command in a stdenv for building with given buildInputs
      wrapped = command: buildInputs:
        runCommandCC "${command}-wrapped" { inherit buildInputs; } ''
          type -P '${command}' || { echo '${command}: not found'; exit 1; }
          cat > "$out" <<EOF
          #!$(type -P bash)
          $(declare -xp | sed -e '/^[^=]\+="\('"''${NIX_STORE//\//\\/}"'\|[^\/]\)/!d')
          $(type -P '${command}') "\$@"
          EOF
          chmod +x "$out"
        '';

      # Theano spews warnings and disabled flags if the compiler isn't named g++
      cxx_compiler = wrapped "g++" (stdenv.lib.optionals cudaSupport [ libgpuarray cudnn ]);
    in ''
      substituteInPlace theano/configdefaults.py \
        --subst-var-by cxx_compiler '${cxx_compiler}'
    '' + stdenv.lib.optionalString cudaSupport ''
      substituteInPlace theano/configdefaults.py \
        --subst-var-by nvcc_gcc '${gcc49}/bin' \
        --subst-var-by cuda_root '${cudatoolkit}'
      substituteInPlace theano/gpuarray/dnn.py \
        --subst-var-by cudnn_lib '${cudnn}/lib/libcudnn.so'
    '' + stdenv.lib.optionalString (pythonOlder "3.0") ''
      sed -i -re '1a\' -e 'from builtins import bytes' theano/gpuarray/dnn.py
      sed -i -re "s/(b'30')/int(bytes(\1))/g" theano/gpuarray/dnn.py
      sed -i -re "s/(ctx.bin_id\[\-2:\])/int(\1)/g" theano/gpuarray/dnn.py
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
