{ callPackage, boost155, boost162, boost163, openssl_1_1_0, haskellPackages }:

rec {

  bitcoin  = callPackage ./bitcoin.nix { withGui = true; };
  bitcoind = callPackage ./bitcoin.nix { withGui = false; };

  bitcoin-unlimited  = callPackage ./bitcoin-unlimited.nix { withGui = true; };
  bitcoind-unlimited = callPackage ./bitcoin-unlimited.nix { withGui = false; };

  bitcoin-classic  = callPackage ./bitcoin-classic.nix { withGui = true; boost = boost162; };
  bitcoind-classic = callPackage ./bitcoin-classic.nix { withGui = false; boost = boost162; };

  bitcoin-xt  = callPackage ./bitcoin-xt.nix { withGui = true; };
  bitcoind-xt = callPackage ./bitcoin-xt.nix { withGui = false; };

  btc1 = callPackage ./btc1.nix { withGui = true; };
  btc1d = callPackage ./btc1.nix { withGui = false; };

  dashpay = callPackage ./dashpay.nix { };

  dogecoin  = callPackage ./dogecoin.nix { withGui = true; };
  dogecoind = callPackage ./dogecoin.nix { withGui = false; };

  freicoin = callPackage ./freicoin.nix { boost = boost155; };
  go-ethereum = callPackage ./go-ethereum.nix { };
  go-ethereum-classic = callPackage ./go-ethereum-classic { };

  hivemind = callPackage ./hivemind.nix { withGui = true; boost = boost162; };
  hivemindd = callPackage ./hivemind.nix { withGui = false; boost = boost162; };

  litecoin  = callPackage ./litecoin.nix { withGui = true; };
  litecoind = callPackage ./litecoin.nix { withGui = false; };

  memorycoin  = callPackage ./memorycoin.nix { withGui = true; };
  memorycoind = callPackage ./memorycoin.nix { withGui = false; };

  namecoin = callPackage ./namecoin.nix { withGui = true; boost = pkgs.boost; };
  namecoind = callPackage ./namecoin.nix { withGui = false; boost = pkgs.boost; };

  ethabi = callPackage ./ethabi.nix { };
  ethrun = callPackage ./ethrun.nix { };
  seth = callPackage ./seth.nix { };
  dapp = callPackage ./dapp.nix { };

  hsevm = (haskellPackages.callPackage ./hsevm.nix {});

  primecoin  = callPackage ./primecoin.nix { withGui = true; };
  primecoind = callPackage ./primecoin.nix { withGui = false; };

  stellar-core = callPackage ./stellar-core.nix { };

  zcash = callPackage ./zcash {
    withGui = false;
    openssl = openssl_1_1_0;
    boost = boost163;
  };
}
