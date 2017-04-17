{ stdenv, buildGoPackage, go-bindata, goimports, nix-prefetch-git, git, makeWrapper,
  fetchFromGitHub }:

buildGoPackage rec {
  name = "go2nix-${version}";
  version = "1.2.0";
  rev = "v${version}";

  goPackagePath = "github.com/kamilchm/go2nix";

  src = fetchFromGitHub {
    inherit rev;
    owner = "kamilchm";
    repo = "go2nix";
    sha256 = "1hlanw56r1phj89sicpsfcz6sdjba9qjwhiblcsqka4wfqkai8pn";
  };

  goDeps = ./deps.nix;

  outputs = [ "bin" "out" "man" ];

  buildInputs = [ go-bindata goimports makeWrapper ];
  preBuild = ''go generate ./...'';

  postInstall = ''
    wrapProgram $bin/bin/go2nix \
      --prefix PATH : ${nix-prefetch-git}/bin \
      --prefix PATH : ${git}/bin

    mkdir -p $man/share/man/man1
    cp $src/go2nix.1 $man/share/man/man1
  '';

  allowGoReference = true;

  meta = with stdenv.lib; {
    description = "Go apps packaging for Nix";
    homepage = https://github.com/kamilchm/go2nix;
    license = licenses.mit;
    maintainers = with maintainers; [ kamilchm ];
  };
}
