{ kde, kdelibs, xscreensaver, kde_workspace, eigen, libkexiv2, libXt, pkgconfig }:

kde {
  buildInputs = [ kdelibs xscreensaver kde_workspace eigen libkexiv2 libXt ];

  nativeBuildInputs = [ pkgconfig ];

  prePatch = "cp -v ${./FindXscreensaver.cmake} cmake/modules/FindXscreensaver.cmake";

  cmakeFlags = { BUILD_asciiquarium = true; };

  meta = {
    description = "KDE screensavers";
  };
}
