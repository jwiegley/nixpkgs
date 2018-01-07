{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "skim-${version}";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "lotabout";
    repo = "skim";
    rev = "v${version}";
    sha256 = "1dvvrjvryzffqxqpg10ahg7rx9wkkav1q413bza3x3afb0jlsx15";
  };

  outputs = [ "out" "vim" ];

  cargoSha256 = "0zf3y74382m4347yn1sygzd3g9b6vn5dmckj5nyll20azc6shyvc";

  patchPhase = ''
    sed -i -e "s|expand('<sfile>:h:h')|'$out'|" plugin/skim.vim
  '';

  postInstall = ''
    install -D -m 555 bin/sk-tmux -t $out/bin
    install -D -m 444 shell/* -t $out/share/skim
    install -D -m 444 plugin/skim.vim -t $vim/plugin

    cat <<SCRIPT > $out/bin/sk-share
    #!/bin/sh
    # Run this script to find the skim shared folder where all the shell
    # integration scripts are living.
    echo $out/share/skim
    SCRIPT
    chmod +x $out/bin/sk-share
  '';

  meta = with stdenv.lib; {
    description = "Fuzzy Finder in rust!";
    homepage = https://github.com/lotabout/skim;
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
