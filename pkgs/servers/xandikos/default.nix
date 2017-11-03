{ stdenv, fetchFromGitHub, python3Packages }:

python3Packages.buildPythonApplication rec {
  version = "0.0.6";
  name = "xandikos-${version}";

  src = fetchFromGitHub {
    owner = "jelmer";
    repo = "xandikos";
    rev = "v${version}";
    sha256 = "1y5igby6mz6d172im9rgzy2yapg07vgpb03fhydk6y89h70h03js";
  };

  doCheck = false;

  propagatedBuildInputs = with python3Packages; [
    icalendar
    dulwich
    defusedxml
    jinja2
  ];

  meta = with stdenv.lib; {
    homepage = https://github.com/jelmer/xandikos;
    description = "Lightweight CalDAV/CardDAV server";
    license = licenses.gpl3Plus;
    platforms = platforms.all;
    maintainers = with maintainers; [ matthiasbeyer ];
  };
}

