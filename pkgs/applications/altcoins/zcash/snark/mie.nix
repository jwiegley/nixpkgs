
{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "mie";
  version = "2016-05-10-git";

  src = fetchFromGitHub {
    owner = "herumi";
    repo  = name;
    rev = "704b625b7770a8e1eab26ac65d1fed14c2fcf090";
    sha256 = "144bpmgfs2m4qqv7a2mccgi1aq5jmlr25gnk78ryq09z8cyv88y2";
  };

  phases = ["unpackPhase" "installPhase"];

  installPhase = ''
    mkdir -p $out
    cp -r include $out
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/herumi/mie";
    maintainers = with maintainers; [ jb55 ];
    license = licenses.bsd3;
    platforms = platforms.unix;
  };
}
