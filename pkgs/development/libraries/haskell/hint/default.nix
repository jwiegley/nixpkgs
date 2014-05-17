{ cabal, exceptions, extensibleExceptions, filepath, ghcMtl
, ghcPaths, HUnit, mtl, random, utf8String
}:

cabal.mkDerivation (self: {
  pname = "hint";
  version = "0.4.2.0";
  sha256 = "08cq9zyyry7cxc30jmsdgrnvw6v2jbxnxcwcjs3bh77rds947mmd";
  buildDepends = [
    exceptions extensibleExceptions filepath ghcMtl ghcPaths mtl random
    utf8String
  ];
  testDepends = [
    exceptions extensibleExceptions filepath HUnit mtl
  ];
  meta = {
    homepage = "http://hub.darcs.net/jcpetruzza/hint";
    description = "Runtime Haskell interpreter (GHC API wrapper)";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
