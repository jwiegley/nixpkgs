{ stdenv
, desktop_file_utils
, fetchurl
, gettext
, glib
, gtk3
, itstool
, libglade
, meson, ninja
, pango
, pkgconfig
, polkit
, shared_mime_info
, systemd
}:
let
  major = "3.26";
  version = "${major}.1";
  pname = "sysprof";
in stdenv.mkDerivation rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${major}/${pname}-${version}.tar.xz";
    sha256 = "049vbbrz3ihjam6v32s76fyly0bwvhqjfcbafyiy95k64k1dbffq";
  };

  mesonFlags = "-D systemdunitdir=lib/systemd/system";
  nativeBuildInputs = [ desktop_file_utils gettext itstool meson ninja pkgconfig shared_mime_info ];
  buildInputs = [ glib gtk3 libglade pango polkit systemd.dev systemd.lib ];

  meta = {
    homepage = https://wiki.gnome.org/Apps/Sysprof;
    description = "System-wide profiler for Linux";
    license = stdenv.lib.licenses.gpl2Plus;

    longDescription = ''
      Sysprof is a sampling CPU profiler for Linux that uses the perf_event_open
      system call to profile the entire system, not just a single
      application.  Sysprof handles shared libraries and applications
      do not need to be recompiled.  In fact they don't even have to
      be restarted.
    '';
    platforms = stdenv.lib.platforms.linux;
  };
}
