# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, attoparsec, either, hoodleTypes, lens, mtl, strict, text
, transformers, xournalTypes
}:

cabal.mkDerivation (self: {
  pname = "hoodle-parser";
  version = "0.3.0";
  sha256 = "0qp7x6csacf4w9crvmyrs7qsm9caici95qiwm11zyzyz2k9nm52g";
  buildDepends = [
    attoparsec either hoodleTypes lens mtl strict text transformers
    xournalTypes
  ];
  meta = {
    homepage = "http://ianwookim.org/hoodle";
    description = "Hoodle file parser";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    hydraPlatforms = self.stdenv.lib.platforms.none;
    maintainers = with self.stdenv.lib.maintainers; [ ianwookim ];
  };
})
