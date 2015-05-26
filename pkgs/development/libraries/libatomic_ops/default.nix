{ stdenv, fetchurl, autoconf, automake, libtool }:
let
  s = # Generated upstream information
  rec {
    baseName="libatomic_ops";
    version="7.4.2";
    name="${baseName}-${version}";
    hash="1pdm0h1y7bgkczr8byg20r6bq15m5072cqm5pny4f9crc9gn3yh4";
    url="http://www.ivmaisoft.com/_bin/atomic_ops/libatomic_ops-7.4.2.tar.gz";
    sha256="1pdm0h1y7bgkczr8byg20r6bq15m5072cqm5pny4f9crc9gn3yh4";
  };
  
  buildInputs = stdenv.lib.optionals stdenv.isCygwin [ autoconf automake libtool ];

in stdenv.mkDerivation {
  inherit (s) name version;
  inherit buildInputs;

  src = fetchurl {
    inherit (s) url sha256;
  };

  preConfigure = if stdenv.isCygwin then ''
      sed -i"" -e "/libatomic_ops_gpl_la_SOURCES/a libatomic_ops_gpl_la_LIBADD = libatomic_ops.la" src/Makefile.am
      ./autogen.sh
  '' else null;

  meta = {
    inherit (s) version;
    description = ''A library for semi-portable access to hardware-provided atomic memory update operations'';
    license = stdenv.lib.licenses.gpl2Plus ;
    maintainers = [stdenv.lib.maintainers.raskin];
    platforms = stdenv.lib.platforms.unix;
  };
}
