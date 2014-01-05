{ cabal, alex, cpphs, filepath, HUnit, mtl, parsec, QuickCheck, syb
, testFramework, testFrameworkHunit, testFrameworkQuickcheck2
}:

cabal.mkDerivation (self: {
  pname = "language-java";
  version = "0.2.6";
  sha256 = "1rwkc71c77v1lm5vnfkf7wr4lzvkpdylwz8wia40xwyxidq9qv27";
  buildDepends = [ cpphs parsec syb ];
  testDepends = [
    filepath HUnit mtl QuickCheck testFramework testFrameworkHunit
    testFrameworkQuickcheck2
  ];
  buildTools = [ alex ];
  doCheck = false;
  meta = {
    homepage = "http://github.com/vincenthz/language-java";
    description = "Manipulating Java source: abstract syntax, lexer, parser, and pretty-printer";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
