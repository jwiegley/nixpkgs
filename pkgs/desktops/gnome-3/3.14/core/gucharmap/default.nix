{ stdenv, intltool, fetchurl, pkgconfig, gtk3
, glib, desktop_file_utils, bash, appdata-tools
, makeWrapper, gnome3, file, itstool, libxml2 }:

# TODO: icons and theme still does not work
# use packaged gnome3.adwaita-icon-theme 

stdenv.mkDerivation rec {
  name = "gucharmap-${gnome3.version}.2";

  src = fetchurl {
    url = "mirror://gnome/sources/gucharmap/${gnome3.version}/${name}.tar.xz";
    sha256 = "fdc3e1889c48c0835d349e2910000f62946ee9f2735d7f64d6a3ad5869c87872";
  };

  doCheck = true;

  propagatedUserEnvPkgs = [ gnome3.gnome_themes_standard ];

  preConfigure = "substituteInPlace ./configure --replace /usr/bin/file ${file}/bin/file";

  buildInputs = [ pkgconfig gtk3 intltool itstool glib appdata-tools
                  gnome3.yelp_tools libxml2 file desktop_file_utils
                  gnome3.gsettings_desktop_schemas makeWrapper ];

  preFixup = ''
    wrapProgram "$out/bin/gucharmap" \
      --prefix XDG_DATA_DIRS : "${gnome3.gnome_themes_standard}/share:$out/share:$GSETTINGS_SCHEMAS_PATH"
  '';

  meta = with stdenv.lib; {
    homepage = https://wiki.gnome.org/Apps/Gucharmap;
    description = "GNOME Character Map, based on the Unicode Character Database";
    maintainers = with maintainers; [ lethalman ];
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
