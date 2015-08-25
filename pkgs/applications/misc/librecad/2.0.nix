{ stdenv, fetchurl, qt4, muparser, which, boost, pkgconfig }:

stdenv.mkDerivation {
  name = "librecad-2.0.8";

  src = fetchurl {
    url = https://github.com/LibreCAD/LibreCAD/tarball/2.0.8;
    name = "librecad-2.0.8.tar.gz";
    sha256 = "ec13e47f3c960ae716040a16da0b688c58cd85e63f7c17cd44afc5bf73b01b84";
  };

  patchPhase = ''
    sed -i -e s,/bin/bash,`type -P bash`, scripts/postprocess-unix.sh
    sed -i -e s,/usr/share,$out/share, librecad/src/lib/engine/rs_system.cpp
  '';

  configurePhase = ''
    qmake librecad.pro PREFIX=$out MUPARSER_DIR=${muparser} BOOST_DIR=${boost.dev}
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share
    cp -R unix/librecad $out/bin
    cp -R unix/resources $out/share/librecad
  '';

  buildInputs = [ qt4 muparser which boost ];
  nativeBuildInputs = [ pkgconfig ];

  enableParallelBuilding = true;

  meta = {
    description = "A 2D CAD package based upon Qt";
    homepage = http://librecad.org;
    repositories.git = git://github.com/LibreCAD/LibreCAD.git;
    license = stdenv.lib.licenses.gpl2;
    maintainers = with stdenv.lib.maintainers; [viric];
    platforms = with stdenv.lib.platforms; linux;
  };
}
