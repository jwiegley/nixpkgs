{ stdenv, fetchFromGitHub, gettext, libiconv, bison, ncurses, perl, autoreconfHook }:

stdenv.mkDerivation rec {
  version = "2017-06-12";
  name = "lifelines-unstable-${version}";

  src = fetchFromGitHub {
    owner = "disassembler";
    repo = "lifelines";
    rev = "5bf8bfbdf0462e038c31e89f5b5f255429cd3291";
    sha256 = "183gmqax0sy858c15vq5q4qq9j9lid5xs5ah4whq4q2bc3xrwwa0";
  };

  buildInputs = [
    gettext
    libiconv
    ncurses
    perl
  ];
  nativeBuildInputs = [ autoreconfHook bison ];

  meta = with stdenv.lib; {
    description = "Genealogy tool with ncurses interface";
    homepage = "http://marcno.github.io/lifelines";
    license = licenses.mit;
    maintainers = with maintainers; [ disassembler ];
    platforms = platforms.linux;
  };
}
