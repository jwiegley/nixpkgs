{ stdenv, lib, fetchFromGitHub, makeWrapper, git, gnupg }:

let
  version = "0.2.2";
  repo = "git-secret";

in stdenv.mkDerivation {
  name = "${repo}-${version}";

  src = fetchFromGitHub {
    inherit repo;
    owner = "sobolevn";
    rev = "v${version}";
    sha256 = "0vn9jibp97z7kc828wka1k0d7a9wx4skd6cnqy60kagfc00l0bzh";
  };

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp git-secret $out/bin

    wrapProgram $out/bin/git-secret \
      --prefix PATH : "${lib.makeBinPath [ git gnupg ]}"

    cp -R man $out/
  '';

  meta = {
    description = "A bash-tool to store your private data inside a git repository.";
    homepage = http://git-secret.io;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.lo1tuma ];
    platforms = stdenv.lib.platforms.all;
  };
}
