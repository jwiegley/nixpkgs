{ stdenv, fetchzip, cmake, pkgconfig
, alsaLib, freetype, libjack2, lame, libogg, libpulseaudio, libsndfile, libvorbis
, portaudio, qtbase, qtdeclarative, qtenginio, qtscript, qtsvg, qttools
, qtwebkit, qtxmlpatterns
}:

stdenv.mkDerivation rec {
  name = "musescore-${version}";
  version = "2.0.3";

  src = fetchzip {
    url = "https://github.com/musescore/MuseScore/archive/v${version}.tar.gz";
    sha256 = "067f4li48qfhz2barj70zpf2d2mlii12npx07jx9xjkkgz84z4c9";
  };

  makeFlags = [
    "PREFIX=$(out)"
  ];

  cmakeFlags = {
    AEOLUS = false;
    ZERBERUS = true;
    OSC = true;
    OMR = false; # TODO: add OMR support, CLEF_G not declared error
    OCR = false; # Not necessary without OMR
    SOUNDFONT3 = true;
    HAS_AUDIOFILE = true;
    BUILD_JACK = true;
  };

  preBuild = ''
    make lupdate
    make lrelease
  '';

  postBuild = ''
    make manpages
  '';

  nativeBuildInputs = [ cmake pkgconfig ];

  enableParallelBuilding = true;

  buildInputs = [
    alsaLib libjack2 freetype lame libogg libpulseaudio libsndfile libvorbis
    portaudio qtbase qtdeclarative qtenginio qtscript qtsvg qttools
    qtwebkit qtxmlpatterns #tesseract
  ];

  meta = with stdenv.lib; {
    description = "Music notation and composition software";
    homepage = http://musescore.org/;
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = [ maintainers.vandenoever ];
    repositories.git = https://github.com/musescore/MuseScore;
  };
}
