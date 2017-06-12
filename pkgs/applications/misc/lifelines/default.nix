{ stdenv, fetchgit, autoconf, libtool, automake, pkgconfig, gettext, libiconv
, bison, ncurses, perl }:

stdenv.mkDerivation rec {
  version = "2017-06-12-unstable";
  name = "lifelines-${version}";

  src = fetchgit {
    url = "https://github.com/disassembler/lifelines";
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

  preConfigure = ''
    gettextize -f -c
    aclocal
    autoconf
    autoheader
    automake -a
  '';

  meta = {
    description = "Genealogy tool with ncurses interface";
    homepage = "https://github.com/MarcNo/lifelines";
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.disassembler ];
  };
}
