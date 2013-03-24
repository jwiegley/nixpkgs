{ cabal }:

cabal.mkDerivation (self: {
  pname = "parsec";
  version = "2.1.0.1";
  sha256 = "2d85e5b5c8b2b1f341037ce67e1db7fa47b31c083136796cfef9e5b945c656df";
  meta = {
    homepage = "http://www.cs.uu.nl/~daan/parsec.html";
    description = "Monadic parser combinators";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [
      self.stdenv.lib.maintainers.andres
      self.stdenv.lib.maintainers.simons
    ];
  };
})
