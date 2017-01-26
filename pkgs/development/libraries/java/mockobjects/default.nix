{stdenv, fetchurl} :

stdenv.mkDerivation {
  name = "mockobjects-0.09";
  builder = ./builder.sh;

  src = fetchurl {
    url = mirror://sourceforge/mockobjects/mockobjects-bin-0.09.tar;
    sha256 = "18rnyqfcyh0s3dwkkaszdd50ssyjx5fa1y3ii309ldqg693lfgnz";
  };

  meta = {
    platforms = stdenv.lib.platforms.unix;
  };
}
