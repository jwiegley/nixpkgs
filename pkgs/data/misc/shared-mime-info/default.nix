{stdenv, fetchurl, pkgconfig, gettext, perl, perlXMLParser, intltool
, libxml2, glib}:

let version = "1.6"; in
stdenv.mkDerivation rec {
  name = "shared-mime-info-${version}";

  src = fetchurl {
    url = "http://freedesktop.org/~hadess/${name}.tar.xz";
    sha256 = "0k637g047gci8g69bg4g19akylpfraxm40hd30j3i4v7cidziy5j";
  };

  nativeBuildInputs = [
    pkgconfig gettext intltool perl perlXMLParser libxml2 glib
  ];

  meta = {
    inherit version;
    description = "A database of common MIME types";
    homepage = http://freedesktop.org/wiki/Software/shared-mime-info;
    license = stdenv.lib.licenses.gpl2Plus;
    platforms = stdenv.lib.platforms.unix;
  };
}
