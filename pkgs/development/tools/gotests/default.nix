{ stdenv, lib, buildGoPackage, fetchgit }:

buildGoPackage rec {
  name = "gotests-${version}";
  version = "1.5.2";
  rev = "v${version}";

  goPackagePath = "github.com/cweill/gotests";
  excludedPackages = "testdata";
  goDeps = ./deps.nix;

  src = fetchgit {
    inherit rev;
    url = "https://github.com/cweill/gotests";
    sha256 = "0ff2jvpc1xb5jr6dv9izlpfavxaivzirqmdmicpznrqjz0d56pri";
  };

  meta = {
    description = "Generate Go tests from your source code.";
    homepage = https://github.com/cweill/gotests;
    maintainers = with stdenv.lib.maintainers; [ vdemeester ];
    license = stdenv.lib.licenses.asl20;
  };
}
