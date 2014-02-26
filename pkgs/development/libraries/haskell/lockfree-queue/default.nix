{ cabal, abstractDeque, abstractDequeTests, atomicPrimops, HUnit
, testFramework, testFrameworkHunit
}:

cabal.mkDerivation (self: {
  pname = "lockfree-queue";
  version = "0.2.3";
  sha256 = "0y8ax6vcjnjm8g7ybn95wca74hm0g22fvgra06vj6l90pl93awyg";
  buildDepends = [ abstractDeque atomicPrimops ];
  testDepends = [
    abstractDeque abstractDequeTests atomicPrimops HUnit testFramework
    testFrameworkHunit
  ];
  meta = {
    homepage = "https://github.com/rrnewton/haskell-lockfree/wiki";
    description = "Michael and Scott lock-free queues";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
