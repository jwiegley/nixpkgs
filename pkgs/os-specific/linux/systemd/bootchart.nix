{ stdenv, fetchFromGitHub, autoconf, automake, intltool, pkgconfig, libtool
, libxslt, docbook_xsl, docbook_xml_dtd_45, systemd }:

assert stdenv.isLinux;

stdenv.mkDerivation rec {
  version = "230";
  name = "systemd-bootchart-${version}";

  src = fetchFromGitHub {
    owner = "systemd";
    repo = "systemd-bootchart";
    rev = "v${version}";
    sha256 = "1dbscx7hsvn6a5rbjfmpskwnp0n2hpwdb8n85gssnlmxas7cw72f";
  };

  nativeBuildInputs = [
    autoconf automake intltool pkgconfig libtool libxslt docbook_xsl
    docbook_xml_dtd_45
  ];

  buildInputs = [ systemd ];

  configureFlags = [
    "--sysconfdir=/etc"
    "--localstatedir=/var"
    "--with-rootprefix=$(out)"
  ];

  NIX_CFLAGS_COMPILE = [
    ''-UROOTLIBEXECDIR'' ''-DROOTLIBEXECDIR="/run/current-system/systemd/lib/systemd"''
    ''-USYSTEMD_BINARY_PATH'' ''-DSYSTEMD_BINARY_PATH="/run/current-system/systemd/lib/systemd/systemd"''
  ];

  installFlags = [
    "sysconfdir=$(out)/etc"
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/systemd/systemd-bootchart";
    description = "Boot performance graphing tool";
    platforms = platforms.linux;
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ abbradar ];
  };
}
