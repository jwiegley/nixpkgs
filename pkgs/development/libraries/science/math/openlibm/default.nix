{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "openlibm-${version}";
  version = "0.5.4";
  src = fetchurl {
    url = "https://github.com/JuliaLang/openlibm/archive/v${version}.tar.gz";
    sha256 = "0cwqqqlblj3kzp9aq1wnpfs1fl0qd1wp1xzm5shb09w06i4rh9nn";
  };

  makeFlags = [ "prefix=$(out)" ];

  meta = {
    description = "High quality system independent, portable, open source libm implementation";
    homepage = http://www.openlibm.org/;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.ttuegel ];
    platforms = stdenv.lib.platforms.all;
  };
}
