{ stdenv, fetchurl, makeWrapper, pkgconfig, intltool, itstool, libvirt-glib
, glib, gobjectIntrospection, libxml2, gtk3, gtkvnc, libvirt, spice_gtk
, spice_protocol, libuuid, libsoup, libosinfo, systemd, tracker, vala
, libcap_ng, libcap, yajl, gmp, gdbm, cyrus_sasl, gnome3, librsvg
, hicolor_icon_theme, desktop_file_utils, mtools, cdrkit, libcdio
}:

# TODO: ovirt (optional)

stdenv.mkDerivation rec {
  name = "gnome-boxes-${gnome3.version}.2";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-boxes/${gnome3.version}/${name}.tar.xz";
    sha256 = "7bfa27a4575c3b84e5818358cc554bc1385ef717aaecdb3d7d48c34b0451ea31";
  };

  enableParallelBuilding = true;

  doCheck = true;

  buildInputs = [
    makeWrapper pkgconfig intltool itstool libvirt-glib glib
    gobjectIntrospection libxml2 gtk3 gtkvnc libvirt spice_gtk spice_protocol
    libuuid libsoup libosinfo systemd tracker vala libcap_ng libcap yajl gmp
    gdbm cyrus_sasl gnome3.adwaita-icon-theme
    librsvg hicolor_icon_theme desktop_file_utils
  ];

  preFixup = ''
    for prog in "$out/bin/"*; do
        wrapProgram "$prog" \
            --set GDK_PIXBUF_MODULE_FILE "$GDK_PIXBUF_MODULE_FILE" \
            --prefix XDG_DATA_DIRS : "${gnome3.gnome_themes_standard}/share:$XDG_ICON_DIRS:$GSETTINGS_SCHEMAS_PATH" \
            --prefix PATH : "${mtools}/bin:${cdrkit}/bin:${libcdio}/bin"
    done
  '';

  meta = with stdenv.lib; {
    description = "Simple GNOME 3 application to access remote or virtual systems";
    homepage = https://wiki.gnome.org/action/show/Apps/Boxes;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ bjornfor ];
  };
}
