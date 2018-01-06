{ stdenv, fetchFromGitHub, autoreconfHook, libpcap, makeWrapper, perlPackages }:

stdenv.mkDerivation rec {
  name = "arp-scan-${version}";
  version = "2017-07-17";

  src = fetchFromGitHub {
    owner = "royhills";
    repo = "arp-scan";
    rev = "75f4f63f0bf7c36895c579e22b599c7702b0e667";
    sha256 = "0lpb6mg2gx1pxdiks6spr02r4k5zlkx1slg53n68mk8k158m1pas";
  };

  perlModules = with perlPackages; [
    HTTPDate
    HTTPMessage
    LWPUserAgent
    URI
  ];

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ libpcap makeWrapper ];

  postInstall = ''
    for name in get-{oui,iab}; do
      wrapProgram "$out/bin/$name" --set PERL5LIB "${stdenv.lib.makePerlPath perlModules }"
    done;
  '';

  meta = with stdenv.lib; {
    description = "ARP scanning and fingerprinting tool";
    longDescription = ''
      Arp-scan is a command-line tool that uses the ARP protocol to discover
      and fingerprint IP hosts on the local network.
    '';
    homepage = http://www.nta-monitor.com/wiki/index.php/Arp-scan_Documentation;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ bjornfor mikoim ];
  };
}
