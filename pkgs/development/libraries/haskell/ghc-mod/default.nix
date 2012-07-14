{ cabal, Cabal, emacs, filepath, ghcPaths, ghcSybUtils, hlint
, ioChoice, regexPosix, syb, transformers
}:

cabal.mkDerivation (self: {
  pname = "ghc-mod";
  version = "1.11.0";
  sha256 = "19cx6jhciww2xgad3q35h3jlwiv9s9b6na2qi1cbga7p77swarsv";
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    Cabal filepath ghcPaths ghcSybUtils hlint ioChoice regexPosix syb
    transformers
  ];
  buildTools = [ emacs ];
  postInstall = ''
      cd $out/share/$pname-$version
      make
      rm Makefile
      cd ..
      ensureDir "$out/share/emacs"
      mv $pname-$version emacs/site-lisp
    '';
  meta = {
    homepage = "http://www.mew.org/~kazu/proj/ghc-mod/";
    description = "Happy Haskell programming on Emacs/Vim";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [
      self.stdenv.lib.maintainers.andres
      self.stdenv.lib.maintainers.bluescreen303
    ];
  };
})
