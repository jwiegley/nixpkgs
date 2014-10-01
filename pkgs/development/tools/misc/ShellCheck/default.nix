# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, json, mtl, parsec, QuickCheck, regexCompat }:

cabal.mkDerivation (self: {
  pname = "ShellCheck";
  version = "0.3.4";
  sha256 = "07fw8c33p7h1kvg899dwnvqpxpywcidhbw9jhjd8xsma7kz471iw";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [ json mtl parsec QuickCheck regexCompat ];
  testDepends = [ json mtl parsec QuickCheck regexCompat ];
  meta = {
    homepage = "http://www.shellcheck.net/";
    description = "Shell script analysis tool";
    license = self.stdenv.lib.licenses.lgpl3;
    maintainers = with self.stdenv.lib.maintainers; [ aycanirican ];
    platforms = self.ghc.meta.platforms;
  };
})
