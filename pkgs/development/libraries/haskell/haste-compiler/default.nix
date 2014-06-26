{ cabal, binary, blazeBuilder, bzlib, dataBinaryIeee754
, dataDefault, executablePath, filepath, ghcPaths, HTTP, monadsTf
, mtl, network, random, shellmate, systemFileio, tar, temporary
, time, transformers, utf8String, websockets, zipArchive
}:

cabal.mkDerivation (self: {
  pname = "haste-compiler";
  version = "0.3";
  sha256 = "0a0hyra1h484c404d95d411l7gddaazy1ikwzlgkgzaqzd7j7dbd";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    binary blazeBuilder bzlib dataBinaryIeee754 dataDefault
    executablePath filepath ghcPaths HTTP monadsTf mtl network random
    shellmate systemFileio tar temporary time transformers utf8String
    websockets zipArchive
  ];
  meta = {
    homepage = "http://github.com/valderman/haste-compiler";
    description = "Haskell To ECMAScript compiler";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.tomberek ];
  };
})
