{ cabal, binary, blazeBuilder, dataBinaryIeee754, network
, QuickCheck, testFramework, testFrameworkQuickcheck2, time
, transformers
}:

cabal.mkDerivation (self: {
  pname = "hosc";
  version = "0.15";
  sha256 = "1yp25n159p69r32y3x7iwc55l5q9qaamj2vyl1473x8ras5afdcf";
  buildDepends = [
    binary blazeBuilder dataBinaryIeee754 network time transformers
  ];
  testDepends = [
    QuickCheck testFramework testFrameworkQuickcheck2
  ];
  meta = {
    homepage = "http://rd.slavepianos.org/t/hosc";
    description = "Haskell Open Sound Control";
    license = "GPL";
    platforms = self.ghc.meta.platforms;
  };
})
