{ stdenv, fetchurl, libpng, pkgconfig }:

stdenv.mkDerivation rec {
  name = "qrencode-3.4.3";

  src = fetchurl {
    url = "${meta.homepage}/${name}.tar.bz2";
    sha256 = "163sb580p570p27imc6jhkfdw15kzp8vy1jq92nip1rwa63i9myz";
  };

  buildInputs = [ libpng ];
  nativeBuildInputs = [ pkgconfig ];

  patches = [ ./00_configure_fix ./01_pkg_config_fix ./03_libpthread_handling_fix ];

  meta = {
    homepage = http://fukuchi.org/works/qrencode/;
    description = "QR code encoder";
    platforms = stdenv.lib.platforms.all;
    maintainers = [ stdenv.lib.maintainers.urkud ];
  };
}
