{ lib, stdenv, fetchurl, fetchFromGitHub, cmake, pkgconfig, xorg, mesa_glu
, mesa_noglu, glew, ocl-icd, python3
, cudaSupport ? false, cudatoolkit
, darwin
}:

stdenv.mkDerivation rec {
  name = "opensubdiv-${version}";
  version = "3.3.0";

  src = fetchFromGitHub {
    owner = "PixarAnimationStudios";
    repo = "OpenSubdiv";
    rev = "v${lib.replaceChars ["."] ["_"] version}";
    sha256 = "0wpjwfik4q9s4r30hndhzmfyzv968mmg5lgng0123l07mn47d2yl";
  };

  outputs = [ "out" "dev" ];

  buildInputs =
    [ cmake pkgconfig mesa_glu mesa_noglu python3
      # FIXME: these are not actually needed, but the configure script wants them.
      glew xorg.libX11 xorg.libXrandr xorg.libXxf86vm xorg.libXcursor
      xorg.libXinerama xorg.libXi
    ]
    ++ lib.optional (!stdenv.isDarwin) ocl-icd
    ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [OpenCL Cocoa CoreVideo IOKit AppKit AGL ])
    ++ lib.optional cudaSupport cudatoolkit;

  cmakeFlags =
    [ "-DNO_TUTORIALS=1"
      "-DNO_REGRESSION=1"
      "-DNO_EXAMPLES=1"
      "-DNO_METAL=1" # don’t have metal in apple sdk
    ] ++ lib.optionals (!stdenv.isDarwin) [
      "-DGLEW_INCLUDE_DIR=${glew.dev}/include"
      "-DGLEW_LIBRARY=${glew.dev}/lib"
    ] ++ lib.optional cudaSupport "-DOSD_CUDA_NVCC_FLAGS=--gpu-architecture=compute_30";

  enableParallelBuilding = true;

  postInstall = "rm $out/lib/*.a";

  meta = {
    description = "An Open-Source subdivision surface library";
    homepage = http://graphics.pixar.com/opensubdiv;
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.eelco ];
    license = lib.licenses.asl20;
  };
}
