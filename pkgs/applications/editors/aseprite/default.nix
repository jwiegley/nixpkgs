{ stdenv, fetchurl, cmake, pkgconfig
, giflib, libjpeg, zlib, libpng, tinyxml, allegro
, libX11, libXext, libXcursor, libXpm, libXxf86vm, libXxf86dga
}:

stdenv.mkDerivation rec {
  name = "aseprite-0.9.5";

  src = fetchurl {
    url = "http://aseprite.googlecode.com/files/${name}.tar.xz";
    sha256 = "0m7i6ybj2bym4w9rybacnnaaq2jjn76vlpbp932xcclakl6kdq41";
  };

  buildInputs = [
    cmake pkgconfig
    giflib libjpeg zlib libpng tinyxml allegro
    libX11 libXext libXcursor libXpm libXxf86vm libXxf86dga
  ];

  patchPhase = ''
    sed -i '/^find_unittests/d' src/CMakeLists.txt
    sed -i '/include_directories(.*third_party\/gtest.*)/d' src/CMakeLists.txt
    sed -i '/add_subdirectory(gtest)/d' third_party/CMakeLists.txt
    sed -i 's/png_\(sizeof\)/\1/g' src/file/png_format.cpp
  '';

  cmakeFlags = {
    USE_SHARED_GIFLIB = true;
    USE_SHARED_JPEGLIB = true;
    USE_SHARED_ZLIB = true;
    USE_SHARED_LIBPNG = true;
    USE_SHARED_LIBLOADPNG = true;
    USE_SHARED_TINYXML = true;
    USE_SHARED_GTEST = true;
    USE_SHARED_ALLEGRO4 = true;
    ENABLE_UPDATER = false;
  };

  NIX_LDFLAGS = "-lX11";

  meta = {
    description = "Animated sprite editor & pixel art tool";
    homepage = "http://www.aseprite.org/";
    license = stdenv.lib.licenses.gpl2Plus;
    platforms = stdenv.lib.platforms.linux;
  };
}
