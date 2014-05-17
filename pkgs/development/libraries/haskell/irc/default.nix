{ cabal, attoparsec }:

cabal.mkDerivation (self: {
  pname = "irc";
  version = "0.6.0.1";
  sha256 = "0524phrxjv0i5qabrf4sj0zpcvkdvcivv1lg46591pmvndfhpyn4";
  buildDepends = [ attoparsec ];
  meta = {
    description = "A small library for parsing IRC messages";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
