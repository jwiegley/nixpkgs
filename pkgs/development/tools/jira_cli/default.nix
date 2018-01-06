{ stdenv, pkgs }:
let
  python = import ./requirements.nix { inherit pkgs; };
in
  python.packages.jira-cli.overrideAttrs ( old: rec {
    meta = with stdenv.lib; old.meta // {
      description = "A command line interface to Jira";
      homepage = http://github.com/alisaifee/jira-cli;
      maintainers = with maintainers; [ nyarly ];
      license = licenses.mit;
    };
  })
