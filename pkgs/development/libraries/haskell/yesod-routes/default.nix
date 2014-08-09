# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, hspec, HUnit, pathPieces, text, vector }:

cabal.mkDerivation (self: {
  pname = "yesod-routes";
  version = "1.2.0.7";
  sha256 = "00i2nysbhmxnq0dvfdjx6nhxy680ya38nx8gcgm13fv2xwdd2p6j";
  buildDepends = [ pathPieces text vector ];
  testDepends = [ hspec HUnit pathPieces text ];
  meta = {
    homepage = "http://www.yesodweb.com/";
    description = "Efficient routing for Yesod";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
