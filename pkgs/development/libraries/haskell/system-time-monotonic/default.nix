{ cabal, time }:

cabal.mkDerivation (self: {
  pname = "system-time-monotonic";
  version = "0.2";
  sha256 = "0f5grhh6x2fbawmdk0gq1nsjz47iz8f8r2592d1l69fqddwdhc3v";
  buildDepends = [ time ];
  meta = {
    homepage = "https://github.com/joeyadams/haskell-system-time-monotonic";
    description = "Simple library for using the system's monotonic clock";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
