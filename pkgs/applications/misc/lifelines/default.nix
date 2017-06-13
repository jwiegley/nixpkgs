{ stdenv, fetchFromGitHub, autoconf, libtool, automake, pkgconfig
, gettext, libiconv, bison, ncurses, perl, autoreconfHook }:

stdenv.mkDerivation rec {
  version = "2017-06-12";
  name = "lifelines-unstable-${version}";

  src = fetchFromGitHub {
    owner = "MarcNo";
    repo = "lifelines";
    rev = "61974641d9e2ca6ee808597d934b0f70eab69a56";
    sha256 = "1nqn395pljwdz3rbanqcakzs00svqk53xjazfp66rqzia7wdh0s5";
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
