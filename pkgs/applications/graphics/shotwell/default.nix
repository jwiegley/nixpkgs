{ fetchurl, stdenv, m4, glibc, gtk3, libexif, libgphoto2, libsoup, libxml2, vala_0_28, sqlite
, webkitgtk, pkgconfig, gnome3, gst_all_1, which, udev, libgudev, libraw, glib, json_glib
, gettext, desktop_file_utils, lcms2, gdk_pixbuf, librsvg, wrapGAppsHook
, gnome_doc_utils, hicolor_icon_theme, itstool, libgdata }:

# for dependencies see http://www.yorba.org/projects/shotwell/install/

stdenv.mkDerivation rec {
  version = "${major}.${minor}";
  major = "0.26";
  minor = "1";
  name = "shotwell-${version}";

  src = fetchurl {
    url = "mirror://gnome/sources/shotwell/${major}/${name}.tar.xz";
    sha256 = "0xak1f69lp1yx3p8jgmr9c0z3jypi8zjpy3kiknn5n9g2f5cqq0a";
  };

  NIX_CFLAGS_COMPILE = "-I${glib.dev}/include/glib-2.0 -I${glib.out}/lib/glib-2.0/include";

  configureFlags = [ "--disable-gsettings-convert-install" ];

  preConfigure = ''
    patchShebangs .
  '';

  buildInputs = [ m4 glibc gtk3 libexif libgphoto2 libsoup libxml2 vala_0_28 sqlite webkitgtk
                  pkgconfig gst_all_1.gstreamer gst_all_1.gst-plugins-base gnome3.libgee
                  which udev libgudev gnome3.gexiv2 hicolor_icon_theme
                  libraw json_glib gettext desktop_file_utils glib lcms2 gdk_pixbuf librsvg
                  wrapGAppsHook gnome_doc_utils gnome3.rest gnome3.gcr
                  gnome3.defaultIconTheme itstool libgdata ];

  meta = with stdenv.lib; {
    description = "Popular photo organizer for the GNOME desktop";
    homepage = https://wiki.gnome.org/Apps/Shotwell;
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [domenkozar];
    platforms = platforms.linux;
  };
}
