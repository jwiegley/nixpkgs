{ cabal, fay, fayBase, text }:

cabal.mkDerivation (self: {
  pname = "fay-text";
  version = "0.3.0.2";
  sha256 = "12hgamqbrflmnr3ri0ajvzf6al5nn4adcdmv6ag6h5mrsik2sklf";
  buildDepends = [ fay fayBase text ];
  meta = {
    homepage = "https://github.com/faylang/fay-text";
    description = "Fay Text type represented as JavaScript strings";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
