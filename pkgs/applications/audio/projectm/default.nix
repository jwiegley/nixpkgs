{ stdenv, fetchurl, pkgconfig, cmake
, glew, ftgl, ttf_bitstream_vera
, withQt ? true, qt4
, withLibvisual ? false, libvisual, SDL
, withJack ? false, libjack2
, withPulseAudio ? true, libpulseaudio
}:

assert withJack       -> withQt;
assert withPulseAudio -> withQt;

stdenv.mkDerivation {
  name = "projectm-2.1.0";

  meta = {
    description = "Music Visualizer";
    homepage = "http://projectm.sourceforge.net/";
    license = stdenv.lib.licenses.lgpl21Plus;
    platforms = stdenv.lib.platforms.linux;
  };

  src = fetchurl {
    url = "mirror://sourceforge/projectm/2.1.0/projectM-complete-2.1.0-Source.tar.gz";
    sha256 = "1vh6jk68a0jdb6qwppb6f8cbgmhnv2ba3bcavzfd6sq06gq08cji";
  };

  patchPhase = ''
    sed -i 's:''${LIBVISUAL_PLUGINSDIR}:''${CMAKE_INSTALL_PREFIX}/lib/libvisual-0.4:' \
      src/projectM-libvisual/CMakeLists.txt
  '';

  nativeBuildInputs = [ pkgconfig cmake ];

  cmakeFlags = {
    projectM_FONT_MENU = "${ttf_bitstream_vera}/share/fonts/truetype/VeraMono.ttf";
    projectM_FONT_TITLE = "${ttf_bitstream_vera}/share/fonts/truetype/Vera.ttf";
    INCLUDE-PROJECTM-TEST = false;
    INCLUDE-PROJECTM-QT = withQt;
    INCLUDE-PROJECTM-LIBVISUAL = withLibvisual;
    INCLUDE-PROJECTM-JACK = withJack;
    INCLUDE-PROJECTM-PULSEAUDIO = withPulseAudio;
  };

  buildInputs = with stdenv.lib;
    [ glew ftgl ]
    ++ optional withQt qt4
    ++ optionals withLibvisual [ libvisual SDL ]
    ++ optional withJack libjack2
    ++ optional withPulseAudio libpulseaudio
    ;
}
