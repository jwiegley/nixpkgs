{ cabal, configurator, heist, mtl, snap, stripe, text, textFormat
, transformers, xmlhtml
}:

cabal.mkDerivation (self: {
  pname = "snaplet-stripe";
  version = "0.2.0";
  sha256 = "01ichbwk31zfjq5rc09scz0j4ir6b7jnppdvmm8ilvkj7bl442xs";
  buildDepends = [
    configurator heist mtl snap stripe text textFormat transformers
    xmlhtml
  ];
  meta = {
    homepage = "https://github.com/LukeHoersten/snaplet-stripe";
    description = "Stripe snaplet for the Snap Framework";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
