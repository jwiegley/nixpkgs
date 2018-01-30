{ stdenv, fetchFromGitHub, rustPlatform, cmake, CoreServices, cf-private }:

rustPlatform.buildRustPackage rec {
  name = "gutenberg-${version}";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "Keats";
    repo = "gutenberg";
    rev = "v${version}";
    sha256 = "17jm9ps6l1sqcyfpanr7wj5g1ihdpxk4pmm6jardn3y0ijw10dnr";
  };

  cargoSha256 = "1nj45y5346pmb2yilq8qm82i9q9qflyzamv573ypvdpsgmhp7jc8";

  nativeBuildInputs = [ cmake ];
  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ CoreServices cf-private ];

  postInstall = ''
    install -D -m 444 completions/gutenberg.bash-completion \
      $out/share/bash-completion/completions/gutenberg
    install -D -m 444 completions/_gutenberg \
      -t $out/share/zsh/site-functions
    install -D -m 444 completions/gutenberg.fish \
      -t $out/share/fish/vendor_completions.d
  '';

  meta = with stdenv.lib; {
    description = "An opinionated static site generator with everything built-in";
    homepage = https://www.getgutenberg.io;
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
