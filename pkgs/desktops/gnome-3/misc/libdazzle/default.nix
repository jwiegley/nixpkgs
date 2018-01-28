{ stdenv, pkgs, fetchurl, ninja, meson, pkgconfig, glib, gtk3, vala, ...}:

let
  major = "3.27";
  version = "${major}.2";
  pname = "libdazzle";
in
stdenv.mkDerivation {
  name = "${pname}-${version}";

  buildInputs = [ glib gtk3 ];
  nativeBuildInputs = [ ninja meson pkgconfig vala ];

  outputs = [ "out" "dev" ];

  src = fetchurl {
    url = "mirror://gnome/sources/libdazzle/${major}/${pname}-${version}.tar.xz";
    sha256 = "1h1dib10i06xhx48qq1yim5k3gddskjd2pbs246zj4w0dkv9in8d";
  };

  meta = with stdenv.lib; {
    description = ''
      The libdazzle library is a companion library to GObject and Gtk+. It
      provides various features that we wish were in the underlying library but
      cannot for various reasons. In most cases, they are wildly out of scope
      for those libraries. In other cases, our design isn't quite generic
      enough to work for everyone.
    '';
    homepage = https://wiki.gnome.org/Apps/Builder;
    license = licenses.gpl2;
  };
}
