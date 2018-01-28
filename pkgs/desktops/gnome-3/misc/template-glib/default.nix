{ stdenv, fetchurl, meson, ninja, pkgconfig, glib, gobjectIntrospection, flex, bison, vala, gettext, ... }:
let
  major = "3.27";
  version = "${major}.2";
  pname = "template-glib";
in
stdenv.mkDerivation {
  name = "${pname}-${version}";

  buildInputs = [ meson ninja pkgconfig glib ];
  nativeBuildInputs = [ gettext glib gobjectIntrospection flex bison vala ];
  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${major}/${pname}-${version}.tar.xz";
    sha256 = "1f2q4rwhv1hbkwaw2l6xz8vp7x53lljlhhmisz0s4d1bc12k9q11";
  };

  meta = with stdenv.lib; {
    description = ''
      A library for template expansion which supports calling into GObject
      Introspection from templates.
    '';
    license = licenses.gpl2;
  };
}
