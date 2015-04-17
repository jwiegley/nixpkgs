{ stdenv, intltool, fetchurl, libxml2, webkitgtk, highlight
, pkgconfig, gtk3, glib, hicolor_icon_theme, libnotify, gtkspell3
, makeWrapper, itstool, shared_mime_info, libical, db, gcr, sqlite
, gnome3, librsvg, gdk_pixbuf, libsecret, nss, nspr, icu, libtool
, libcanberra_gtk3, bogofilter, gst_all_1, procps, p11_kit }:

let
  majVer = gnome3.version;
in stdenv.mkDerivation rec {
  name = "evolution-${majVer}.0";

  src = fetchurl {
    url = "mirror://gnome/sources/evolution/${majVer}/${name}.tar.xz";
    sha256 = "16czk00qb730fkp6fn0i60y2s77kj5vaznc8wmr5qmrnia2f86mr";
  };

  doCheck = true;

  propagatedUserEnvPkgs = [ gnome3.gnome_themes_standard ];

  propagatedBuildInputs = [ gnome3.gtkhtml ];

  buildInputs = [ pkgconfig gtk3 glib intltool itstool libxml2 libtool
                  gdk_pixbuf gnome3.adwaita-icon-theme librsvg db icu
                  gnome3.evolution_data_server libsecret libical gcr
                  webkitgtk shared_mime_info gnome3.gnome_desktop gtkspell3
                  libcanberra_gtk3 bogofilter gnome3.libgdata sqlite
                  gst_all_1.gstreamer gst_all_1.gst-plugins-base p11_kit
                  hicolor_icon_theme gnome3.adwaita-icon-theme
                  nss nspr libnotify procps highlight gnome3.libgweather
                  gnome3.gsettings_desktop_schemas makeWrapper ];

  configureFlags = [ "--disable-spamassassin" "--disable-pst-import" "--disable-autoar"
                     "--disable-libcryptui" ];

  NIX_CFLAGS_COMPILE = "-I${nspr}/include/nspr -I${nss}/include/nss -I${glib}/include/gio-unix-2.0";

  enableParallelBuilding = true;

  preFixup = ''
    for f in $out/bin/* $out/libexec/*; do
      wrapProgram "$f" \
        --set GDK_PIXBUF_MODULE_FILE "$GDK_PIXBUF_MODULE_FILE" \
        --prefix XDG_DATA_DIRS : "${gnome3.gnome_themes_standard}/share:$XDG_ICON_DIRS:$GSETTINGS_SCHEMAS_PATH"
    done
  '';

  meta = with stdenv.lib; {
    homepage = https://wiki.gnome.org/Apps/Evolution;
    description = "Personal information management application that provides integrated mail, calendaring and address book functionality";
    maintainers = with maintainers; [ lethalman ];
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
  };
}
