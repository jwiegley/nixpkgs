{ cabal, aeson, binary, blazeBuilder, Cabal, caseInsensitive
, cmdargs, conduit, deepseq, filepath, haskellSrcExts, httpTypes
, parsec, QuickCheck, random, resourcet, safe, shake, tagsoup
, temporary, text, time, transformers, uniplate, vector
, vectorAlgorithms, wai, warp
}:

cabal.mkDerivation (self: {
  pname = "hoogle";
  version = "4.2.36";
  sha256 = "1h65pl0jfki2pcrywak9mh3hfi3wziffhb2q0xp6r4v01536zifv";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    aeson binary blazeBuilder Cabal caseInsensitive cmdargs conduit
    deepseq filepath haskellSrcExts httpTypes parsec QuickCheck random
    resourcet safe shake tagsoup text time transformers uniplate vector
    vectorAlgorithms wai warp
  ];
  testDepends = [ filepath temporary ];
  testTarget = "--test-option=--no-net";
  meta = {
    homepage = "http://www.haskell.org/hoogle/";
    description = "Haskell API Search";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
