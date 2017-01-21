# This file was generated by go2nix.
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "frakti-${version}";
  version = "20170111-${stdenv.lib.strings.substring 0 7 rev}";
  rev = "5c414e8021c964c735310625364e6f872a68e54b";

  goPackagePath = "k8s.io/frakti";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/kubernetes/frakti.git";
    sha256 = "1m1d9bzx6swbjg7j5w8dmjlxg7fysf6diys4y4773816ja4m6nwi";
  };

  goDeps = ./deps.nix;

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
    maintainer = with maintainers; [ moretea ];
  };
}
