{ stdenv, fetchFromGitHub, gcc49 }:

stdenv.mkDerivation rec {
  name = "ksh-2012-08-01";

  src = fetchFromGitHub {
    owner = "att";
    repo = "ast";
    rev = "3f54fd611f536639ec30dd53c48e5ec1897cc7d9";
    sha256 = "0wsdxn2nqwf420j39k51kxbwc0ka7wlkbs113mk5grblac18phgh";
  };

  hardeningDisable = [ "all" ];

  nativeBuildInputs = [ gcc49 ];

  buildPhase = ''
    substituteInPlace src/cmd/probe/Mamfile \
      --replace "chmod u+s,+x" "chmod +x"

    bin/package make || true
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/man/man1
    arch=`bin/package host`
    mv arch/$arch/bin/ksh $out/bin
    mv arch/$arch/man/man1/sh.1 $out/share/man/man1/ksh.1
  '';

  meta = with stdenv.lib; {
    description = "AT&T KornShell";
    homepage = http://www.kornshell.org/;
    license = licenses.epl10;
    platforms = platforms.linux;
  };
}
