{ stdenv, fetchFromGitHub, autoconf, libtool, automake, pkgconfig
, gettext, libiconv, bison, ncurses, perl, autoreconfHook }:

stdenv.mkDerivation rec {
  version = "2017-06-12-unstable";
  name = "lifelines-${version}";

  src = fetchFromGitHub {
    owner = "disassembler";
    repo = "lifelines";
    rev = "71f3fa98b8939bd2217d5d76f83b5e5c596ab4de";
    sha256 = "02rb15gwxv5c2kw86yib1wr9xhvly7h9fi604kwmsvl6yf3hbihy";
  };

  buildInputs = [
    autoconf
    automake
    libtool
    pkgconfig
    gettext
    libiconv
    bison
    ncurses
    perl
  ];
  nativeBuildInputs = [ autoreconfHook ];

  meta = with stdenv.lib; {
    description = "Genealogy tool with ncurses interface";
    homepage = "http://marcno.github.io/lifelines";
    license = licenses.mit;
    maintainers = with maintainers; [ disassembler ];
    platforms = platforms.linux;
  };
}
