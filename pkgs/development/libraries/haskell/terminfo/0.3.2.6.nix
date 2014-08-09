# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, ncurses }:

cabal.mkDerivation (self: {
  pname = "terminfo";
  version = "0.3.2.6";
  sha256 = "0ag81rwwwaanxdn9ccanvdi1qnh62vy8y2jbgp5bp95hhgqq887f";
  extraLibraries = [ ncurses ];
  meta = {
    homepage = "http://code.haskell.org/terminfo";
    description = "Haskell bindings to the terminfo library";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    hydraPlatforms = self.stdenv.lib.platforms.none;
  };
})
