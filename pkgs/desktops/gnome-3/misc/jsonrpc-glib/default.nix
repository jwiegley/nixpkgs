{ stdenv, fetchurl, meson, ninja, glib, json_glib, pkgconfig, gobjectIntrospection, vala}:
let
  major = "3.27";
  version = "${major}.1";
  pname = "jsonrpc-glib";
in
stdenv.mkDerivation {
  name = "${pname}-${version}";

  nativeBuildInputs = [ meson ninja pkgconfig gobjectIntrospection vala ];
  buildInputs = [ glib json_glib ];

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${major}/${pname}-${version}.tar.xz";
    sha256 = "1z5mwcqf49gwnrhiqgs2hk2x77609av76i55lgih0lzrhw61wa06";
  };

  meta = with stdenv.lib; {
    description = ''
      jsonrpc-glib is a library to communicate using the JSON-RPC 2.0
      specification.
    '';
    license = licenses.lgpl2Plus;
  };

}
