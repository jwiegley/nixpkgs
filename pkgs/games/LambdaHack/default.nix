# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, assertFailure, async, binary, deepseq, enummapsetTh
, filepath, gtk, hashable, hsini, keys, miniutter, mtl, prettyShow
, random, stm, text, transformers, unorderedContainers, vector
, vectorBinaryInstances, zlib
}:

cabal.mkDerivation (self: {
  pname = "LambdaHack";
  version = "0.2.14";
  sha256 = "1nygyzrgzrv7qfr153xvkh50p0sjrbv3jbif7qmpam5jjlw26ahs";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    assertFailure async binary deepseq enummapsetTh filepath gtk
    hashable hsini keys miniutter mtl prettyShow random stm text
    transformers unorderedContainers vector vectorBinaryInstances zlib
  ];
  testDepends = [
    assertFailure async binary deepseq enummapsetTh filepath hashable
    hsini keys miniutter mtl prettyShow random stm text transformers
    unorderedContainers vector vectorBinaryInstances zlib
  ];
  doCheck = false;
  meta = {
    homepage = "http://github.com/LambdaHack/LambdaHack";
    description = "A roguelike game engine in early development";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
