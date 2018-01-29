{ stdenv, fetchurl, autoreconfHook, docbook_xml_dtd_412, docbook_xml_dtd_42, docbook_xml_dtd_43, docbook_xsl, which, libxml2
, gobjectIntrospection, gtk_doc, intltool, libxslt, pkgconfig, xmlto, appstream-glib
, bubblewrap, bzip2, dbus, fuse, glib, gpgme, json_glib, libarchive, libcap, libseccomp
, libsoup, lzma, ostree, polkit, python3, systemd, xlibs, valgrind }:

let
  version = "0.10.2.1";
in stdenv.mkDerivation rec {
  name = "flatpak-${version}";

  src = fetchurl {
    url = "https://github.com/flatpak/flatpak/releases/download/${version}/${name}.tar.xz";
    sha256 = "01y808flfg6ivpg2s81szdpmfpwp08xaqhycq68pxlb1n2xcrk87";
  };

  nativeBuildInputs = [
    autoreconfHook libxml2 docbook_xml_dtd_412 docbook_xml_dtd_42 docbook_xml_dtd_43 docbook_xsl which gobjectIntrospection
    gtk_doc intltool libxslt pkgconfig xmlto appstream-glib
  ] ++ stdenv.lib.optionals doCheck checkInputs;
  buildInputs = [
    bubblewrap bzip2 dbus fuse glib gpgme json_glib libarchive libcap libseccomp
    libsoup lzma ostree polkit python3 systemd xlibs.libXau
  ];
  checkInputs = [ valgrind ];

  doCheck = false;

  configureFlags = [
    "--with-system-bubblewrap"
    "--localstatedir=/var"
  ];

  patches = [
    # patch taken from gtk_doc
    ./respect-xml-catalog-files-var.patch
  ];

  postPatch = ''
    patchShebangs buildutil
    patchShebangs tests
  '';

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  meta = with stdenv.lib; {
    description = "Linux application sandboxing and distribution framework";
    homepage = https://flatpak.org/;
    license = licenses.lgpl21;
    maintainers = with maintainers; [ jtojnar ];
    platforms = platforms.linux;
  };
}
