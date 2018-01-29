{ stdenv
, jedi, mccabe, future, rope, tox
, yapf, pycodestyle, pluggy, pyflakes
, json-rpc, pydocstyle, pytest
, fetchPypi
, buildPythonApplication
, pythonOlder
, configparser ? null
}:
buildPythonApplication rec {

  pname = "python-language-server";
  version = "0.13.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1ym8xrqngb02icg1n0jndmd2bgnigy2xczi1lbhfyw6n9jr8p4m7";
  };

  postPatch = stdenv.lib.optionalString (!pythonOlder "3.0") ''
    substituteInPlace setup.py --replace 'configparser'  ""
  '';

  propagatedBuildInputs = [
    future
    mccabe
    jedi
    json-rpc
    yapf
    pycodestyle
    pydocstyle
    pyflakes
    pluggy
    rope
  ] ++ stdenv.lib.optionals (pythonOlder "3.0") [ configparser ];

  # Enabling tests require porting these extra packages
  checkInputs = [ pytest ];

  meta = with stdenv.lib; {
    homepage = http://github.com/palantir/python-language-server;
    description = "Language Server for Python";
    license = licenses.mit;
  };
}

