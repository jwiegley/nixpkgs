# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, binary, filepath, haskellSrcExts, HaTeX, hint, parsec
, text, transformers
}:

cabal.mkDerivation (self: {
  pname = "haskintex";
  version = "0.5.0.1";
  sha256 = "14x1n7x0dqcj14qkv0lmf2jcrswyjjjygqj5vdj6w29a8v9zr296";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    binary filepath haskellSrcExts HaTeX hint parsec text transformers
  ];
  meta = {
    homepage = "http://daniel-diaz.github.io/projects/haskintex";
    description = "Haskell Evaluation inside of LaTeX code";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
