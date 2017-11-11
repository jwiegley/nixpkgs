{ stdenv, fetchurl, gnome3, libtool, pkgconfig, vala, libssh2
, gtk_doc, gobjectIntrospection, libgit2, glib }:

stdenv.mkDerivation rec {
  inherit (import ./src.nix fetchurl) name src;

  nativeBuildInputs = [
    gnome3.gnome_common libtool pkgconfig vala gtk_doc gobjectIntrospection
  ];

  buildInputs = [ libssh2 libgit2 glib ];

  meta = with stdenv.lib; {
    platforms = platforms.linux;
  };
}
