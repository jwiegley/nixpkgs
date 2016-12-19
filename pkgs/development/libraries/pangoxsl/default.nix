{stdenv, fetchurl, pkgconfig, glib, pango}:

stdenv.mkDerivation {
  name = "pangoxsl-1.6.0.3";
  src = fetchurl {
    url = mirror://sourceforge/pangopdf/pangoxsl-1.6.0.3.tar.gz;
    sha256 = "1wcd553nf4nwkrfrh765cyzwj9bsg7zpkndg2hjs8mhwgx04lm8n";
  };

  buildInputs = [
    pkgconfig
    glib
    pango
  ];

  meta = {
    platforms = stdenv.lib.platforms.unix;
  };
}
