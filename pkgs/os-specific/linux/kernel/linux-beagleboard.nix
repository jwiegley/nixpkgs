{ stdenv, hostPlatform, fetchFromGitHub, perl, buildLinux, ... } @ args:

let
  modVersion = "4.9.61";
  tag = "r76";
in
import ./generic.nix (args // rec {
  inherit modVersion;

  version = "${modVersion}-ti-${tag}";

  src = fetchFromGitHub {
    owner = "beagleboard";
    repo = "linux";
    rev = "${version}";
    sha256 = "0hcz4fwjyic42mrn8qsvzm4jq1g5k51awjj3d2das7k8frjalaby";
  };

  kernelPatches = args.kernelPatches;

  features = {
    efiBootStub = false;
  } // (args.features or {});

  extraMeta.hydraPlatforms = [];
} // (args.argsOverride or {}))
