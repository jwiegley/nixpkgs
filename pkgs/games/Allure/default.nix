# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, enummapsetTh, filepath, LambdaHack, text }:

cabal.mkDerivation (self: {
  pname = "Allure";
  version = "0.4.99.0";
  sha256 = "1i4v1h4ynx4aap0nmf8qn2qx22wqfgypr83l7bh38fd4qibsvx3q";
  isLibrary = false;
  isExecutable = true;
  buildDepends = [ enummapsetTh filepath LambdaHack text ];
  testDepends = [ enummapsetTh filepath LambdaHack text ];
  meta = {
    homepage = "http://allureofthestars.com";
    description = "Near-future Sci-Fi roguelike and tactical squad game";
    license = "unknown";
    platforms = self.ghc.meta.platforms;
  };
})
