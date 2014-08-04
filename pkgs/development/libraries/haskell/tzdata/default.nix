# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, filemanip, filepath, HUnit, MissingH, testFramework
, testFrameworkHunit, testFrameworkTh, vector
}:

cabal.mkDerivation (self: {
  pname = "tzdata";
  version = "0.1.20140612.0";
  sha256 = "03fd3jiw89c8zf2jdz0qps8sb8ipgmjqbbaq4y2aqczv36ha74gh";
  buildDepends = [ vector ];
  testDepends = [
    filemanip filepath HUnit MissingH testFramework testFrameworkHunit
    testFrameworkTh
  ];
  meta = {
    homepage = "https://github.com/nilcons/haskell-tzdata";
    description = "Time zone database (as files and as a module)";
    license = self.stdenv.lib.licenses.asl20;
    platforms = self.ghc.meta.platforms;
  };
})
