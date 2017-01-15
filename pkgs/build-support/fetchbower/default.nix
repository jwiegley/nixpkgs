{ stdenv, lib, nodePackages, cacert }:
let
  bowerVersion = version:
    let
      components = lib.splitString "#" version;
      hash = lib.last components;
      ver = if builtins.length components == 1 then version else hash;
    in ver;

  fetchbower = name: version: target: outputHash: stdenv.mkDerivation {
    name = "${name}-${bowerVersion version}";
    SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
    buildCommand = ''
      fetch-bower --quiet --out=$PWD/out "${name}" "${target}" "${version}"
      # In some cases, the result of fetchBower is different depending
      # on the output directory (e.g. if the bower package contains
      # symlinks). So use a local output directory before copying to
      # $out.
      cp -R out $out
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    inherit (nodePackages) bower2nix;
    inherit outputHash;
    buildInputs = [ nodePackages.bower2nix ];
  };

in fetchbower
