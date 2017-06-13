{ stdenv, fetchFromGitHub, autoconf, libtool, automake, pkgconfig
, gettext, libiconv, bison, ncurses, perl, autoreconfHook }:

stdenv.mkDerivation rec {
  version = "2017-06-12";
  name = "lifelines-unstable-${version}";

  src = fetchFromGitHub {
    owner = "MarcNo";
    repo = "lifelines";
    rev = "714b237e55793f229bbb7a599e534cc319a6a502";
    sha256 = "0k8bb1i0q72q2nppcf5y51ps82nm566pcldl50wpjrp7lsspqqpw";
  };

  hardeningDisable = [ "format" ];
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
