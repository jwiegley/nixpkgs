# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, aeson, aesonPretty, attoparsec, attoparsecBinary
, base16Bytestring, binary, binaryBits, cmdargs, cpu, fetchgit, mtl
, network, stm, time, utf8String, xml
}:

cabal.mkDerivation (self: {
  pname = "wayland-tracker";
  version = "0.4.0.0";
  src = fetchgit {
    url = "http://github.com/01org/wayland-tracker.git";
    sha256 = "7a1454eaf6a70857560095161b6eacc8f5637e4bd843b2018040adbbbcf5df74";
    rev = "88b790423a428160a774b9919fe9dcfa21e29297";
  };
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    aeson aesonPretty attoparsec attoparsecBinary base16Bytestring
    binary binaryBits cmdargs cpu mtl network stm time utf8String xml
  ];
  meta = {
    description = "Message dumper for Wayland protocol";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
