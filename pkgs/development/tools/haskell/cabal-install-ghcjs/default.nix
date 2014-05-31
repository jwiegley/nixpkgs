{ cabal, CabalGhcjs, filepath, HTTP, HUnit, mtl, network, QuickCheck
, random, stm, testFramework, testFrameworkHunit
, testFrameworkQuickcheck2, time, zlib, fetchgit
}:

cabal.mkDerivation (self: {
  pname = "cabal-install-ghcjs";
  version = "9e87d6a3";
  src = fetchgit {
    url = git://github.com/ghcjs/cabal.git;
    rev = "9e87d6a39ec63f569fea899fc1ace332ea7eea78";
    sha256 = "07bgsqzmiqzw14i91y5nmk5m9sqnxn503xzv2jan5g33z1vcwdcj";
  };
  isLibrary = true;
  isExecutable = true;
  configureFlags = "--program-suffix=-js";
  preConfigure = "cd cabal-install";
  buildDepends = [
    CabalGhcjs filepath HTTP mtl network random stm time zlib
  ];
  testDepends = [
    CabalGhcjs filepath HTTP HUnit mtl network QuickCheck stm testFramework
    testFrameworkHunit testFrameworkQuickcheck2 time zlib
  ];
  postInstall = ''
    mkdir $out/etc
    mv bash-completion $out/etc/bash_completion.d
  '';
  meta = {
    homepage = "http://www.haskell.org/cabal/";
    description = "The command-line interface for Cabal and Hackage";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
