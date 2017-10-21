{ stdenv, fetchurl, pkgconfig, atk, cairo, glib, gtk3, pango
, libxml2Python, perl, intltool, gettext, gnome3 }:

stdenv.mkDerivation rec {
  inherit (import ./src.nix fetchurl) name src;

  propagatedBuildInputs = [ gtk3 ];

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ atk cairo glib pango
                  libxml2Python perl intltool gettext ];

  preBuild = ''
    substituteInPlace gtksourceview/gtksourceview-utils.c --replace "@NIX_SHARE_PATH@" "$out/share"
  '';

  patches = [ ./nix_share_path.patch ];

  meta = with stdenv.lib; {
    platforms = with platforms; linux ++ darwin;
    maintainers = gnome3.maintainers;
  };
}
