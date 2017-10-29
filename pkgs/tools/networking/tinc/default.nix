{stdenv, fetchurl, lzo, openssl, zlib}:

stdenv.mkDerivation rec {
  version = "1.0.32";
  name = "tinc-${version}";

  src = fetchurl {
    url = "http://www.tinc-vpn.org/packages/tinc-${version}.tar.gz";
    sha256 = "11smq1h6jyp6x2cwrv2zxck9phzdz3svi95pxnvvpd4dzzm4zcjd";
  };

  buildInputs = [ lzo openssl zlib ];

  configureFlags = [
    "--localstatedir=/var"
    "--sysconfdir=/etc"
  ];

  meta = {
    description = "VPN daemon with full mesh routing";
    longDescription = ''
      tinc is a Virtual Private Network (VPN) daemon that uses tunnelling and
      encryption to create a secure private network between hosts on the
      Internet.  It features full mesh routing, as well as encryption,
      authentication, compression and ethernet bridging.
    '';
    homepage="https://www.tinc-vpn.org/";
    license = stdenv.lib.licenses.gpl2Plus;
    platforms = stdenv.lib.platforms.unix;
  };
}
