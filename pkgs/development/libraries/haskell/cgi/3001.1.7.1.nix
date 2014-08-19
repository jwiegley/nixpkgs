# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, mtl, network, parsec, xhtml }:

cabal.mkDerivation (self: {
  pname = "cgi";
  version = "3001.1.7.1";
  sha256 = "7d1d710871fffbbec2a33d7288b2959ddbcfd794d47f0122127576c02550b339";
  buildDepends = [ mtl network parsec xhtml ];
  meta = {
    description = "A library for writing CGI programs";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    hydraPlatforms = self.stdenv.lib.platforms.none;
  };
})
