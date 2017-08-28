{ callPackage, pkgs }:
rec {
  #### CORE EFL
  efl = callPackage ./efl.nix {
    openjpeg = pkgs.openjpeg_1;
    openssl = pkgs.openssl_1_0_2;
  };

  #### WINDOW MANAGER
  enlightenment = callPackage ./enlightenment.nix { };

  #### APPLICATIONS
  econnman = callPackage ./econnman.nix { };
  terminology = callPackage ./terminology.nix { };
  rage = callPackage ./rage.nix { };
  ephoto = callPackage ./ephoto.nix { };
}
