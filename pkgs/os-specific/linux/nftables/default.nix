{ stdenv, fetchurl, pkgconfig, docbook2x, docbook_xml_dtd_45
, flex, bison, libmnl, libnftnl, gmp, readline }:

stdenv.mkDerivation rec {
  name = "nftables-0.8";

  src = fetchurl {
    url = "http://netfilter.org/projects/nftables/files/${name}.tar.bz2";
    sha256 = "16iq9x0qxikdhp1nan500rk33ycqddl1k57876m4dfv3n7kqhnrz";
  };

  configureFlags = [
    "CONFIG_MAN=y"
    "DB2MAN=docbook2man"
  ];

  nativeBuildInputs = [ pkgconfig docbook2x docbook_xml_dtd_45 flex bison ];
  buildInputs = [ libmnl libnftnl gmp readline ];

  meta = with stdenv.lib; {
    description = "The project that aims to replace the existing {ip,ip6,arp,eb}tables framework";
    homepage = http://netfilter.org/projects/nftables;
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ wkennington ];
  };
}
