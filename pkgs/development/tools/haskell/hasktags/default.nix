{ cabal, filepath, json, utf8String }:

cabal.mkDerivation (self: {
  pname = "hasktags";
  version = "0.69.0";
  sha256 = "1bba6w5h5a5frc899cdlxcyshiqdni6lcqby618akr1917ih1qh8";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [ filepath json utf8String ];
  meta = {
    homepage = "http://github.com/MarcWeber/hasktags";
    description = "Produces ctags \"tags\" and etags \"TAGS\" files for Haskell programs";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
