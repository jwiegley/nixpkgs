{ mkDerivation, lib, fetchurl,
  cmake, extra-cmake-modules, qtwebkit, qtscript, grantlee,
  kxmlgui, kwallet, kparts, kdoctools, kjobwidgets, kdesignerplugin,
  kiconthemes, knewstuff, sqlcipher, qca-qt5, kactivities, karchive,
  kguiaddons, knotifyconfig, krunner, kwindowsystem, libofx, shared_mime_info
}:

mkDerivation rec {
  name = "skrooge-${version}";
  version = "2.10.5";

  src = fetchurl {
    url = "http://download.kde.org/stable/skrooge/${name}.tar.xz";
    sha256 = "1c1yihypb6qgbzfcrw4ylqr9zivyba10xzvibrmfkrilxi6i582n";
  };

  nativeBuildInputs = [
    cmake extra-cmake-modules kdoctools shared_mime_info
  ];

  buildInputs = [
    qtwebkit qtscript grantlee kxmlgui kwallet kparts
    kjobwidgets kdesignerplugin kiconthemes knewstuff sqlcipher qca-qt5
    kactivities karchive kguiaddons knotifyconfig krunner kwindowsystem libofx
  ];

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];

  meta = with lib; {
    description = "A personal finances manager, powered by KDE";
    license = with licenses; [ gpl3 ];
    maintainers = with maintainers; [ joko ];
    homepage = https://skrooge.org/;
  };
}
