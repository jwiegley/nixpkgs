# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, mtl, syb }:

cabal.mkDerivation (self: {
  pname = "Strafunski-StrategyLib";
  version = "5.0.0.4";
  sha256 = "0miffjc8li5l1jarmz8l34z5mx3q68pyxghsi1lbda51bzz3wy1g";
  buildDepends = [ mtl syb ];
  jailbreak = true;
  meta = {
    description = "Library for strategic programming";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
