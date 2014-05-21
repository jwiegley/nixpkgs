# XXX: this may need -liconv on non-glibc systems.. 

{ stdenv, fetchFromGitHub, python, perl, autoconf, automake, libtool, intltool, flex }:

stdenv.mkDerivation rec {
  name = "recode-3.7-2fd838565";

  src = fetchFromGitHub {
    owner = "pinard";
    repo = "Recode";
    rev = "2fd8385658e5a08700e3b916053f6680ff85fdbd";
    sha256 = "06vyjqaraamcc5vka66mlvxj27ihccqc74aymv2wn8nphr2rhh03";
  };

  buildInputs = [ python perl autoconf automake libtool intltool flex ];

  preConfigure = ''
    # fix build with new automake, https://bugs.gentoo.org/show_bug.cgi?id=419455
    #rm acinclude.m4
    substituteInPlace Makefile.am --replace "ACLOCAL = ./aclocal.sh @ACLOCAL@" ""
    sed -i '/^AM_C_PROTOTYPES/d' configure.ac
    substituteInPlace src/Makefile.am --replace "ansi2knr" ""

    autoreconf -fi
  ''
  + stdenv.lib.optionalString stdenv.isDarwin ''
    export LDFLAGS=-lintl
  '';

  #doCheck = true; # doesn't work yet

  preCheck = ''
    checkFlagsArray=(CPPFLAGS="-I../lib" LDFLAGS="-L../src/.libs -Wl,-rpath=../src/.libs")
  '';

  meta = {
    homepage = "http://www.gnu.org/software/recode/";
    description = "Converts files between various character sets and usages";
    platforms = stdenv.lib.platforms.unix;
    license = stdenv.lib.licenses.gpl2Plus;
    maintainers = with stdenv.lib.maintainers; [ jcumming ];
  };
}
