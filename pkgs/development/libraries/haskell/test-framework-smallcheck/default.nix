{ cabal, smallcheck, testFramework, transformers }:

cabal.mkDerivation (self: {
  pname = "test-framework-smallcheck";
  version = "0.2";
  sha256 = "1xpgpk1gp4w7w46b4rhj80fa0bcyz8asj2dcjb5x1c37b7rw90b0";
  buildDepends = [ smallcheck testFramework transformers ];
  meta = {
    homepage = "https://github.com/feuerbach/smallcheck";
    description = "Support for SmallCheck tests in test-framework";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
