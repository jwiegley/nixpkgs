# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, aeson, blazeBuilder, conduit, monadControl, monadLogger
, mysql, mysqlSimple, persistent, resourcet, text, transformers
}:

cabal.mkDerivation (self: {
  pname = "persistent-mysql";
  version = "2.0.4";
  sha256 = "098fh3wiqq9frw3v8rmsr0n7raq81p0fmi3an0jh7h4k0b2vz2gc";
  buildDepends = [
    aeson blazeBuilder conduit monadControl monadLogger mysql
    mysqlSimple persistent resourcet text transformers
  ];
  meta = {
    homepage = "http://www.yesodweb.com/book/persistent";
    description = "Backend for the persistent library using MySQL database server";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
