# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, filepath, lens, mtl, split, time, transformersBase, yi }:

cabal.mkDerivation (self: {
  pname = "yi-contrib";
  version = "0.8.2";
  sha256 = "17rbgrra1ghlywiraadf16n7igxp1k8jqqmb0iw8sc15y7825qqm";
  broken = true;
  buildDepends = [
    filepath lens mtl split time transformersBase yi
  ];
  meta = {
    homepage = "http://haskell.org/haskellwiki/Yi";
    description = "Add-ons to Yi, the Haskell-Scriptable Editor";
    license = "GPL";
    broken = true;
    platforms = self.ghc.meta.platforms;
    hydraPlatforms = self.stdenv.lib.platforms.none;
    maintainers = with self.stdenv.lib.maintainers; [ fuuzetsu ];
  };
})
