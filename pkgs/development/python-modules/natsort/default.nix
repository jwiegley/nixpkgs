{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, hypothesis
, pytestcache
, pytestcov
, pytestflakes
, pytestpep8
, pytest
, glibcLocales
, mock ? null
, pathlib ? null
}:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "natsort";
  version = "5.0.3";

  buildInputs = [
    hypothesis
    pytestcache
    pytestcov
    pytestflakes
    pytestpep8
    pytest
    glibcLocales
  ]
  # pathlib was made part of standard library in 3.5:
  ++ (lib.optionals (pythonOlder "3.4") [ pathlib ])
  # based on testing-requirements.txt:
  ++ (lib.optionals (pythonOlder "3.3") [ mock ]);

  src = fetchPypi {
    inherit pname version;
    sha256 = "1h87n0jcsi6mgjx1pws6g1lmcn8jwabwxj8hq334jvziaq0plyym";
  };

  # do not run checks on nix_run_setup.py
  patches = [ ./setup.patch ];

  # testing based on project's tox.ini
  checkPhase = ''
    pytest --doctest-modules natsort
    pytest --flakes --pep8 --cov natsort --cov-report term-missing
  '';

  meta = {
    description = "Natural sorting for python";
    homepage = https://github.com/SethMMorton/natsort;
    license = lib.licenses.mit;
  };
}
