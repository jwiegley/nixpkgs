{ stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, gtk_doc, gobjectIntrospection
, libgsystem, xz, e2fsprogs, libsoup, gpgme, which, autoconf, automake, libtool, fuse
, libarchive, libcap, bzip2, yacc, libxslt, docbook_xsl, docbook_xml_dtd_42
}:

let
  libglnx-src = fetchFromGitHub {
    owner  = "GNOME";
    repo   = "libglnx";
    rev    = "96b1fd9578b3d6ff2d8e0707068f5ef450eba98c";
    sha256 = "121g0rrhd98cnw3wd72p9i0gx0w26dpv60ciywmvp0bawxk350fk";
  };

  bsdiff-src = fetchFromGitHub {
    owner  = "mendsley";
    repo   = "bsdiff";
    rev    = "1edf9f656850c0c64dae260960fabd8249ea9c60";
    sha256 = "1h71d2h2d3anp4msvpaff445rnzdxii3id2yglqk7af9i43kdsn1";
  };

  version = "2018.1";
in stdenv.mkDerivation {
  name = "ostree-${version}";

  src = fetchFromGitHub {
    rev    = "v${version}";
    owner  = "ostreedev";
    repo   = "ostree";
    sha256 = "12gayj95d8w06mp0z17daqfp08qfqp3ii7d8ndkiwhbvy365kg3b";
  };

  nativeBuildInputs = [
    autoconf automake libtool pkgconfig gtk_doc gobjectIntrospection which yacc
    libxslt docbook_xsl docbook_xml_dtd_42
  ];

  buildInputs = [ libgsystem xz e2fsprogs libsoup gpgme fuse libarchive libcap bzip2 ];

  prePatch = ''
    rmdir libglnx bsdiff
    cp --no-preserve=mode -r ${libglnx-src} libglnx
    cp --no-preserve=mode -r ${bsdiff-src} bsdiff
  '';

  preConfigure = ''
    env NOCONFIGURE=1 ./autogen.sh

    configureFlags+="--with-systemdsystemunitdir=$out/lib/systemd/system"
  '';

  meta = with stdenv.lib; {
    description = "Git for operating system binaries";
    homepage    = https://ostree.readthedocs.io/en/latest/;
    license     = licenses.lgpl2Plus;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ copumpkin ];
  };
}

