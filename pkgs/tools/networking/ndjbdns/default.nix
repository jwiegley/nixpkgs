{ stdenv, fetchFromGitHub, autoreconfHook, systemd, pkgconfig }:

with stdenv.lib;

stdenv.mkDerivation rec {
  version = "1.06";
  name = "ndjbdns-${version}";

  src = fetchFromGitHub {
    owner = "pjps";
    repo = "ndjbdns";
    rev = "64d371b6f887621de7bf8bd495be10442b2accd0";
    sha256 = "0gjyvn8r66kp49gasd6sqfvg2pj0c6v67hnq7cqwl04kj69rfy86";
  };

  buildInputs = [ autoreconfHook pkgconfig ]
    ++ optional stdenv.isLinux systemd;

  meta = {
    description = "A brand new release of the Djbdns";
    longDescription = ''
      Djbdns is a fully‐fledged Domain Name System(DNS), originally written by the eminent author of qmail, Dr. D J Bernstein.
    '';
    homepage = http://pjp.dgplug.org/ndjbdns/;
    license = licenses.gpl2;
    maintainers = [ maintainers.msackman ];
    platforms = platforms.linux ++ platforms.darwin;
  };

}
