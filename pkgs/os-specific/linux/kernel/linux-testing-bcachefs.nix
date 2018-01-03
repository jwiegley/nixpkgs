{ stdenv, hostPlatform, fetchgit, perl, buildLinux, ... } @ args:

import ./generic.nix (args // rec {
  version = "4.13.2018.01.03";
  modDirVersion = "4.13.0";
  extraMeta.branch = "master";
  extraMeta.maintainers = [ stdenv.lib.maintainers.davidak ];

  src = fetchgit {
    url = "https://evilpiepirate.org/git/bcachefs.git";
    rev = "01d52ab2c12118fffb89efca2213ec3379191414";
    sha256 = "0yw0n9h66nza5871r70pq8g9x7ad11bs35wvbfx3vflc5a895278";
  };

  extraConfig = ''
    BCACHEFS_FS m
  '';

  # Should the testing kernels ever be built on Hydra?
  extraMeta.hydraPlatforms = [];

} // (args.argsOverride or {}))
