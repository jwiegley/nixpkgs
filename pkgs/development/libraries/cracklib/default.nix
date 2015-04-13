{ stdenv, fetchurl, libintlOrEmpty, zlib, gettext }:

stdenv.mkDerivation rec {
  name = "cracklib-2.9.2";

  src = fetchurl {
    url = "mirror://sourceforge/cracklib/${name}.tar.gz";
    sha256 = "1xarjwga2bc4hys4fkspcp1cph699ag8gg6gmv8rjgj43llrkj61";
  };

  buildInputs = [ libintlOrEmpty zlib gettext ];

  meta = with stdenv.lib; {
    homepage    = http://sourceforge.net/projects/cracklib;
    description = "A library for checking the strength of passwords";
    maintainers = with maintainers; [ lovek323 ];
    platforms   = platforms.unix;
  };
}
