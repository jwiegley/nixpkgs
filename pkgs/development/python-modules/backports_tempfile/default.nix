{ lib
, python
, buildPythonPackage
, fetchPypi
, setuptools_scm
, backports_weakref
, backportsPostPatch
}:

buildPythonPackage rec {
  pname = "backports.tempfile";
  version = "1.0";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1c648c452e8770d759bdc5a5e2431209be70d25484e1be24876cf2168722c762";
  };

  buildInputs = [ setuptools_scm ];

  propagatedBuildInputs = [ backports_weakref ];

  checkPhase = ''
    ${python.interpreter} -m unittest discover -s tests
  '';

  # requires https://pypi.org/project/backports.test.support
  doCheck = false;
  postPatch = backportsPostPatch;

  meta = {
    description = "Backport of new features in Python's tempfile module";
    license = lib.licenses.psfl;
    homepage = https://github.com/pjdelport/backports.tempfile;
  };
}