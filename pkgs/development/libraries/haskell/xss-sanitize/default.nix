# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, attoparsec, cssText, hspec, HUnit, networkUri, tagsoup
, text, utf8String
}:

cabal.mkDerivation (self: {
  pname = "xss-sanitize";
  version = "0.3.5.4";
  sha256 = "1h9dj234sj216g676la0h73nwm0fw4snik31qi0s754vyy6bcygf";
  buildDepends = [
    attoparsec cssText networkUri tagsoup text utf8String
  ];
  testDepends = [
    attoparsec cssText hspec HUnit networkUri tagsoup text utf8String
  ];
  meta = {
    homepage = "http://github.com/yesodweb/haskell-xss-sanitize";
    description = "sanitize untrusted HTML to prevent XSS attacks";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
