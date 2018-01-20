{ lib
, buildPythonPackage
, six
, pyjwt
, requests
, oauthlib
, requests_oauthlib
, flask
, fetchPypi
}:

buildPythonPackage rec {
  pname = "mwoauth";
  version = "0.3.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1krqz755415z37z1znrc77vi4xyp5ys6fnq4zwcwixjjbzddpavj";
  };

  checkInputs = [ flask ];
  
  propagatedBuildInputs = [ six pyjwt requests oauthlib requests_oauthlib ];

  meta = with lib; {
    description = "A library designed to provide a simple means to performing an OAuth handshake with a MediaWiki installation with the OAuth Extension installed.";
    homepage =  https://github.com/mediawiki-utilities/python-mwoauth;
    license = licenses.mit;
    maintainers = with maintainers; [ ixxie ];
  };
}
