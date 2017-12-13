{ stdenv, fetchurl, makeWrapper
, qtbase, qtquickcontrols, qtscript, qtdeclarative, qmake
, withDocumentation ? false
}:

with stdenv.lib;

let
  baseVersion = "4.5";
  revision = "0";
in

stdenv.mkDerivation rec {
  name = "qtcreator-${version}";
  version = "${baseVersion}.${revision}";

  src = fetchurl {
    url = "http://download.qt-project.org/official_releases/qtcreator/${baseVersion}/${version}/qt-creator-opensource-src-${version}.tar.xz";
    sha256 = "1yfrfma23xxzz8hl43g7pk7ay5lg25l9lscjlih617lyv6jmc0hl";
  };

  buildInputs = [ qtbase qtscript qtquickcontrols qtdeclarative ];

  nativeBuildInputs = [ qmake makeWrapper ];

  doCheck = true;

  enableParallelBuilding = true;

  buildFlags = optional withDocumentation "docs";

  installFlags = [ "INSTALL_ROOT=$(out)" ] ++ optional withDocumentation "install_docs";

  preBuild = optional withDocumentation ''
    ln -s ${getLib qtbase}/$qtDocPrefix $NIX_QT5_TMP/share
  '';

  postInstall = ''
    substituteInPlace $out/share/applications/org.qt-project.qtcreator.desktop \
      --replace "Exec=qtcreator" "Exec=$out/bin/qtcreator"
  '';

  meta = {
    description = "Cross-platform IDE tailored to the needs of Qt developers";
    longDescription = ''
      Qt Creator is a cross-platform IDE (integrated development environment)
      tailored to the needs of Qt developers. It includes features such as an
      advanced code editor, a visual debugger and a GUI designer.
    '';
    homepage = https://wiki.qt.io/Category:Tools::QtCreator;
    license = "LGPL";
    maintainers = [ maintainers.akaWolf ];
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}
