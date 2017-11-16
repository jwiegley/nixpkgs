{ callPackage, cudatoolkit7, cudatoolkit75, cudatoolkit8, cudatoolkit9 }:

let
  generic = args: callPackage (import ./generic.nix (removeAttrs args ["cudatoolkit"])) {
    inherit (args) cudatoolkit;
  };

in

{
  cudnn_cudatoolkit7 = generic rec {
    # Old URL is v4 instead of v4.0 for some reason...
    version = "4";
    cudatoolkit = cudatoolkit7;
    srcName = "cudnn-${cudatoolkit.majorVersion}-linux-x64-v4.0-prod.tgz";
    sha256 = "01a4v5j4v9n2xjqcc4m28c3m67qrvsx87npvy7zhx7w8smiif2fd";
  };

  cudnn_cudatoolkit75 = generic rec {
    version = "6.0";
    cudatoolkit = cudatoolkit75;
    srcName = "cudnn-${cudatoolkit.majorVersion}-linux-x64-v${version}.tgz";
    sha256 = "0b68hv8pqcvh7z8xlgm4cxr9rfbjs0yvg1xj2n5ap4az1h3lp3an";
  };

  cudnn6_cudatoolkit8 = generic rec {
    version = "6.0";
    cudatoolkit = cudatoolkit8;
    srcName = "cudnn-${cudatoolkit.majorVersion}-linux-x64-v${version}.tgz";
    sha256 = "173zpgrk55ri8if7s5yngsc89ajd6hz4pss4cdxlv6lcyh5122cv";
  };

  cudnn_cudatoolkit8 = generic rec {
    version = "7.0.5";
    cudatoolkit = cudatoolkit8;
    srcName = "cudnn-${cudatoolkit.majorVersion}-linux-x64-v7.tgz";
    sha256 = "9e0b31735918fe33a79c4b3e612143d33f48f61c095a3b993023cdab46f6d66e";
  };

  cudnn_cudatoolkit9 = generic rec {
    version = "7.0.5";
    cudatoolkit = cudatoolkit9;
    srcName = "cudnn-${cudatoolkit.majorVersion}-linux-x64-v7.tgz";
    sha256 = "1a3e076447d5b9860c73d9bebe7087ffcb7b0c8814fd1e506096435a2ad9ab0e";
  };
}
