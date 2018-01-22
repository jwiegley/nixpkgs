{ stdenv, buildPythonApplication, fetchFromGitHub, makeWrapper, cmake
, pytestrunner, pytest, six, pyparsing, asn1ate }:

buildPythonApplication rec {
  pname = "asn2quickder";
  version = "1.2-5";

  src = fetchFromGitHub {
    sha256 = "0qwd3c0q7j8d22frqxrgqjnji36slnm8c2px6iyrvpd85xamza44";
    rev = "version-${version}";
    owner = "vanrein";
    repo = "quick-der";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ makeWrapper pytestrunner pytest six ];
  propagatedBuildInputs = [ asn1ate ];

  meta = with stdenv.lib; {
    description = "An ASN.1 compiler with a backend for Quick DER";
    homepage = https://github.com/vanrein/asn2quickder;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ leenaars ];
  };
}
