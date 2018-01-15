{ lib
, buildPythonPackage
, fetchFromGitHub
, pytest
, mock
, numpy
, multipledispatch
, dateutil
}:

let
  # Fetcher function looks similar to fetchPypi.
  # Allows for easier overriding, without having to know
  # how the source is actually fetched.
  fetcher = {pname, version, sha256}: fetchFromGitHub {
    owner = "blaze";
    repo = pname;
    rev = version;
    inherit sha256;
  };

in buildPythonPackage rec {
  pname = "datashape";
  version = "0.5.4";

  src = fetcher {
    inherit pname version;
    sha256 = "0rhlj2kjj1vx5m73wnc5518rd6cs1zsbgpsvzk893n516k69shcf";
  };

  checkInputs = [ pytest mock ];
  propagatedBuildInputs = [ numpy multipledispatch dateutil ];

  checkPhase = ''
    py.test datashape/tests
  '';

  meta = {
    homepage = https://github.com/ContinuumIO/datashape;
    description = "A data description language";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ fridh ];
  };
}