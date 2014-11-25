# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, controlMonadFree, haskeline, mtl, transformers }:

cabal.mkDerivation (self: {
  pname = "wizards";
  version = "1.0.1";
  sha256 = "08dn24injfzvhs34yw39y336pyi6p98bdrafx3lhd6lcbp531sca";
  buildDepends = [ controlMonadFree haskeline mtl transformers ];
  jailbreak = true;
  meta = {
    description = "High level, generic library for interrogative user interfaces";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
