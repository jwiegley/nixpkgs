{ stdenv, fetchurl, which}:

stdenv.mkDerivation {
  name = "cntlm-0.92.3";

  src = fetchurl {
    url = mirror://sourceforge/cntlm/cntlm-0.92.3.tar.gz;
    sha256 = "1632szz849wasvh5sm6rm1zbvbrkq35k7kcyvx474gyl4h4x2flw";
  };

  buildInputs = [ which ];

  installPhase = ''
    mkdir -p $out/bin; cp cntlm $out/bin/;
    mkdir -p $out/share/; cp COPYRIGHT README VERSION doc/cntlm.conf $out/share/;
    mkdir -p $out/man/; cp doc/cntlm.1 $out/man/;
  '';

  meta = with stdenv.lib; {
    description = "NTLM/NTLMv2 authenticating HTTP proxy";
    homepage = http://cntlm.sourceforge.net/;
    license = stdenv.lib.licenses.gpl2;
    maintainers = [ stdenv.lib.maintainers.qknight stdenv.lib.maintainers.markWot ];
    platforms = platforms.linux;
  };
}
