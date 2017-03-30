{ stdenv, fetchurl, readline, gettext, ncurses }:

stdenv.mkDerivation rec {
  name = "gnu-apl-${version}";
  version = "1.7";

  src = fetchurl {
    url = "mirror://gnu/apl/apl-${version}.tar.gz";
    sha256 = "07xq8ddlmz8psvsmwr23gar108ri0lwmw0n6kpxcv8ypas1f5xlg";
  };

  buildInputs = [ readline gettext ncurses ];

  patchPhase = stdenv.lib.optionalString stdenv.isDarwin ''
    substituteInPlace src/LApack.cc --replace "malloc.h" "malloc/malloc.h"
  '';

  configureFlags = stdenv.lib.optionals stdenv.isDarwin [
    "--disable-dependency-tracking"
    "--disable-silent-rules"
  ];

  postInstall = ''
    cp -r support-files/ $out/share/doc/
    find $out/share/doc/support-files -name 'Makefile*' -delete
  '';

  meta = with stdenv.lib; {
    description = "Free interpreter for the APL programming language";
    homepage    = http://www.gnu.org/software/apl/;
    license     = licenses.gpl3Plus;
    maintainers = [ maintainers.kovirobi ];
    platforms   = with stdenv.lib.platforms; linux ++ darwin;
    inherit version;

    longDescription = ''
      GNU APL is a free interpreter for the programming language APL, with an
      (almost) complete implementation of ISO standard 13751 aka.  Programming
      Language APL, Extended.  GNU APL was written and is being maintained by
      Jürgen Sauermann.
    '';
  };
}
