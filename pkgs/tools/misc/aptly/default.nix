{ stdenv, buildGoPackage, fetchFromGitHub, makeWrapper, gnupg1compat, bzip2, xz, graphviz }:

buildGoPackage rec {
  name = "aptly-${version}";
  version = "0.9.7";
  rev = "v${version}";

  src = fetchFromGitHub {
    inherit rev;
    owner = "smira";
    repo = "aptly";
    sha256 = "0j1bmqdah4i83r2cf8zcq87aif1qg90yasgf82yygk3hj0gw1h00";
  };

  goPackagePath = "github.com/smira/aptly";
  goDeps = ./deps.nix;

  buildInputs = [ makeWrapper ];

  postInstall = ''
    rm $bin/bin/man
    wrapProgram "$bin/bin/aptly" \
      --prefix PATH ":" "${gnupg1compat}/bin" \
      --prefix PATH ":" "${bzip2.bin}/bin" \
      --prefix PATH ":" "${xz.bin}/bin" \
      --prefix PATH ":" "${graphviz}/bin"
  '';

  meta = with stdenv.lib; {
    homepage = https://www.aptly.info;
    description = "Debian repository management tool";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ maintainers.montag451 ];
  };
}
