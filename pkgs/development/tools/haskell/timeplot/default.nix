{ cabal, bytestringLexing, cairo, Chart, ChartCairo, colour
, dataDefault, lens, regexTdfa, strptime, time, transformers
, vcsRevision
}:

cabal.mkDerivation (self: {
  pname = "timeplot";
  version = "1.0.25";
  sha256 = "14zyzr53gpp0i7wx49zzdrndqdhsw3q4z3w5hdl8c4m541pr25fw";
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    bytestringLexing cairo Chart ChartCairo colour dataDefault lens
    regexTdfa strptime time transformers vcsRevision
  ];
  meta = {
    homepage = "http://haskell.org/haskellwiki/Timeplot";
    description = "A tool for visualizing time series from log files";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
