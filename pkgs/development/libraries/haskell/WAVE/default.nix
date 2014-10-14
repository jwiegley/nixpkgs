# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, parseargs }:

cabal.mkDerivation (self: {
  pname = "WAVE";
  version = "0.1.3";
  sha256 = "1cgla9y1lwcsdad5qdspymd7s6skdw961fgzh02kvi7gjbrrcyi7";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [ parseargs ];
  meta = {
    homepage = "http://github.com/BartMassey/WAVE";
    description = "WAVE audio file IO library";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = with self.stdenv.lib.maintainers; [ fuuzetsu ];
  };
})
