{ stdenv, fetchurl, fetchgit, go, lib }:

let
  inherit (builtins) attrNames listToAttrs getAttr;
  goDeps = {
    goSerf = {
      dir = "github.com/hashicorp";
      name = "serf";
      rev = "21113c8207d8e02b7ff738c9be80fcaabf67251d";
      sha256 = "10lmgb0caffp0x02nriahyfq9p6qkhr8carfq38m8cjxqxs2v0nk";
    };
    goMetrics = {
      dir = "github.com/armon";
      name = "go-metrics";
      rev = "8ceaed1d0bc3a25db6e65e79ee4f895013313c17";
      sha256 = "1yzajmx26br4812m9gz4v7qj6fcmhg4a9jz9l3i20hh2x06srmpg";
    };
    goLogutils = {
      dir = "github.com/hashicorp";
      name = "logutils";
      rev = "8e0820fe7ac5eb2b01626b1d99df47c5449eb2d8";
      sha256 = "184lnn7x1v3xvj6zz1rg9s0252wkkd59kij2iyrrm7y80bym2jys";
    };
    goMemberlist = {
      dir = "github.com/hashicorp";
      name = "memberlist";
      rev = "825ad4aca57c7323e8dadde149bfdec9d9621ffe";
      sha256 = "0mm0hm2kncafq5ml58ki7ilh3b47ni0w19n50ilahhhm4lsfry7z";
    };
    goUgorji = {
      dir = "github.com/ugorji";
      name = "go";
      rev = "cdeae7b76625959e4164eab9eb303087a794f2cc";
      sha256 = "0pcjlbhp6vxnksy12rav6c8bvi2v010407l5hibxqdvnampvhlkb";
    };
    goCli = {
      dir = "github.com/mitchellh";
      name = "cli";
      rev = "69f0b65ce53b27f729b1b807b88dc88007f41dd3";
      sha256 = "0hnnqd8vg5ca2hglkrj141ba2akdh7crl2lsrgz8d6ipw6asszx3";
    };
    goMdns = {
      dir = "github.com/armon";
      name = "mdns";
      rev = "17be83de467449f38a8395c30534a9cf0c03e5ea";
      sha256 = "1fhb6vldclgdx9aqqh1gl87cl5sw3nbq9b7mibkljhbk3cdajyxn";
    };
    goDns = {
      dir = "github.com/miekg";
      name = "dns";
      rev = "5eec7f362c392f0a7eaadea69b13667d665feb82";
      sha256 = "0irlzhd78qmn3lyfbkxmwajv0mm6jp6x0cg7hb9hyj6d01ynlv09";
    };
    goMapstructure = {
      dir = "github.com/mitchellh";
      name = "mapstructure";
      rev = "57bb2fa7a7e00b26c80e4c4b0d4f15a210d94039";
      sha256 = "13lvd5vw8y6h5zl3samkrb7237kk778cky7k7ys1cm46mfd957zy";
    };
  };
  goDepsFetched =
    listToAttrs
      (map (name:
             let
               desc = getAttr name goDeps;
               path = fetchgit { url    = "https://"+desc.dir+"/"+desc.name;
                                 inherit (desc) rev sha256; };
             in { name = name; value = (desc // { inherit path; }); })
           (attrNames goDeps));
  createGoPathCmds =
    lib.concatStrings
      (map (name:
            let fetched = getAttr name goDepsFetched; in ''
            mkdir -p $GOPATH/src/${fetched.dir}
            ln -s ${fetched.path} $GOPATH/src/${fetched.dir}/${fetched.name}
            '') (attrNames goDepsFetched));
in
  stdenv.mkDerivation rec {
    version = "0.4.1";
    name = "serfdom-${version}";

    src = fetchurl {
      url = "https://github.com/hashicorp/serf/archive/v${version}.tar.gz";
      sha256 = "0f4fxhw2r31ks9rs9h3wx9lsymnp8szk0gzggvibwhl2bm6kn6d8";
    };

    buildInputs = [ go ];

    buildPhase = ''
      mkdir $TMPDIR/go
      export GOPATH=$TMPDIR/go
      ${createGoPathCmds}
      go build -v -o bin/serf
    '';

    installPhase = ''
      ensureDir $out/bin
      cp bin/serf $out/bin
    '';

    meta = {
      homepage = http://www.serfdom.io/;
      description = "Serf is a service discovery and orchestration tool that is decentralized, highly available, and fault tolerant";
      platforms = stdenv.lib.platforms.linux;
    };
  }