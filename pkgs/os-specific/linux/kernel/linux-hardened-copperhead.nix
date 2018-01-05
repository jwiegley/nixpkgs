{ stdenv, hostPlatform, fetchFromGitHub, perl, buildLinux, ... } @ args:

with stdenv.lib;

let
  version = "4.14.12";
  revision = "a";
  sha256 = "002a3c177fix472wqc89zrpfzwk60l7dn76l869ivgnd60n6wqb2";

  # modVersion needs to be x.y.z, will automatically add .0 if needed
  modVersion = concatStrings (intersperse "." (take 3 (splitString "." "${version}.0")));

  # branchVersion needs to be x.y
  branchVersion = concatStrings (intersperse "." (take 2 (splitString "." version)));

  modDirVersion = "${modVersion}-hardened";
in
import ./generic.nix (args // {
  inherit modDirVersion;

  version = "${version}-${revision}";
  extraMeta.branch = "${branchVersion}";

  src = fetchFromGitHub {
    inherit sha256;
    owner = "copperhead";
    repo = "linux-hardened";
    rev = "${version}.${revision}";
  };
} // (args.argsOverride or {}))
