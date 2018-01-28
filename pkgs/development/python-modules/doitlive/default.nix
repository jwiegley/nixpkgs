{ lib, buildPythonApplication, fetchPypi,
 click, ipython
}:

buildPythonApplication rec {
  pname = "doitlive";
  name = "${pname}-${version}";
  version = "3.0.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "19i16ca835rb3gal1sxyvpyilj9a80n6nikf0smlzmxck38x86fj";
  };

  propagatedBuildInputs = [ click ];

  checkInputs = [ ipython ];

  meta = with lib; {
    description = "Tool for live presentations in the terminal";
    homepage = https://pypi.python.org/pypi/doitlive;
    license = licenses.mit;
    maintainers = with maintainers; [ mbode ];
  };
}
