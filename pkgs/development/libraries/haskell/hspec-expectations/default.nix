# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, hspec, HUnit, markdownUnlit, silently }:

cabal.mkDerivation (self: {
  pname = "hspec-expectations";
  version = "0.6.0.1";
  sha256 = "16013x7v6zly4h1spzarrlzskbjb19bljsj98fn8k21mzb82f7wl";
  buildDepends = [ HUnit ];
  testDepends = [ hspec HUnit markdownUnlit silently ];
  doCheck = false;
  meta = {
    homepage = "https://github.com/sol/hspec-expectations#readme";
    description = "Catchy combinators for HUnit";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
