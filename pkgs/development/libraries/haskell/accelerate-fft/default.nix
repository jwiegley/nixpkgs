{ cabal, accelerate, accelerateCuda, cuda, cufft }:

cabal.mkDerivation (self: {
  pname = "accelerate-fft";
  version = "0.14.0.0";
  sha256 = "1rsrgrqn1gdds2wvv1mgzd3yg2mvbkgnj63ygjyzsk9j00wavd1g";
  buildDepends = [ accelerate accelerateCuda cuda cufft ];
  meta = {
    homepage = "https://github.com/AccelerateHS/accelerate-fft";
    description = "FFT using the Accelerate library";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    hydraPlatforms = self.stdenv.lib.platforms.none;
  };
})
