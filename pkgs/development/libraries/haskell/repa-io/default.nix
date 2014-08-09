# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, binary, bmp, repa, vector }:

cabal.mkDerivation (self: {
  pname = "repa-io";
  version = "3.3.1.2";
  sha256 = "1i58ysk44y7s6z1jmns2fi83flqma4k5nsjh1pblqb2rgl7x0z5p";
  buildDepends = [ binary bmp repa vector ];
  jailbreak = true;
  meta = {
    homepage = "http://repa.ouroborus.net";
    description = "Read and write Repa arrays in various formats";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
