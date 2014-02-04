{ stdenv, fetchurl, zlib, ncurses, readline, less }:

let version = "8.4.19"; in

stdenv.mkDerivation rec {
  name = "postgresql-${version}";

  src = fetchurl {
    url = "mirror://postgresql/source/v${version}/${name}.tar.bz2";
    sha256 = "f744d04a5d9feeea516fa57fea92be5568527bab03a84cf660a06ce90f90dcea";
  };

  buildInputs = [ zlib ncurses readline ];

  prePatch = ''
    sed -e 's|#define DEFAULT_PAGER.*|#define DEFAULT_PAGER "${less}/bin/less"|' \
        -i src/bin/psql/print.h
  '';

  LC_ALL = "C";

  passthru = { inherit readline; };

  meta = {
    homepage = http://www.postgresql.org/;
    description = "A powerful, open source object-relational database system";
    license = "bsd";
  };
}
