{ stdenv
, runCommandCC
, lib
, fetchPypi
, gcc
, writeScriptBin
, buildPythonPackage
, isPyPy
, pythonOlder
, isPy3k
, nose
, numpy
, pydot_ng
, scipy
, six
, future
, libgpuarray
, cudaSupport ? false, cudatoolkit, gcc49
, cudnnSupport ? false, cudnn
}:

assert cudnnSupport -> cudaSupport;

let
  wrapped = command: buildTop: buildInputs:
    runCommandCC "${command}-wrapped" { inherit buildInputs; } ''
      type -P '${command}' || { echo '${command}: not found'; exit 1; }
      cat > "$out" <<EOF
      #!$(type -P bash)
      $(declare -xp | sed -e '/^[^=]\+="\('"''${NIX_STORE//\//\\/}"'\|[^\/]\)/!d')
      declare -x NIX_BUILD_TOP="${buildTop}"
      $(type -P '${command}') "\$@"
      EOF
      chmod +x "$out"
    '';

  # Theano spews warnings and disabled flags if the compiler isn't named g++
  cxx_compiler = wrapped "g++" "\\$HOME/.theano"
    (    stdenv.lib.optional cudaSupport libgpuarray
      ++ stdenv.lib.optional cudnnSupport cudnn );

  libgpuarray_ = libgpuarray.override { inherit cudaSupport cudatoolkit; };

in buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "Theano";
  version = "1.0.1";

  disabled = isPyPy || pythonOlder "2.6" || (isPy3k && pythonOlder "3.3");

  src = fetchPypi {
    inherit pname version;
    sha256 = "88d8aba1fe2b6b75eacf455d01bc7e31e838c5a0fb8c13dde2d9472495ff4662";
  };

  patches = [
    ./paths.patch
  ] ++ stdenv.lib.optionals cudaSupport [
    ./paths-cuda.patch
    ./memcpy.patch
  ];
  postPatch = ''
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

  preCheck = ''
    mkdir -p check-phase
    export HOME=$(pwd)/check-phase
  '';
  doCheck = false;
  # takes far too long, also throws "TypeError: sort() missing 1 required positional argument: 'a'"
  # when run from the installer, and testing with Python 3.5 hits github.com/Theano/Theano/issues/4276,
  # the fix for which hasn't been merged yet.

  # keep Nose around since running the tests by hand is possible from Python or bash
  checkInputs = [ nose ];
  propagatedBuildInputs = [ numpy numpy.blas scipy six libgpuarray_ ]
    ++ stdenv.lib.optional (pythonOlder "3.0") future;

  passthru = { inherit cudaSupport; };

  meta = with stdenv.lib; {
    homepage = http://deeplearning.net/software/theano/;
    description = "A Python library for large-scale array computation";
    license = licenses.bsd3;
    maintainers = with maintainers; [ maintainers.bcdarwin ];
  };
}
