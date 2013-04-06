{ fetchurl, stdenv, makeWrapper, perl, mesa, xorg }:

stdenv.mkDerivation rec {
  version = "2.8";
  name = "amdapp-sdk-${version}";

  src = if stdenv.system == "x86_64-linux" then fetchurl {
    url = "http://developer.amd.com/wordpress/media/2012/11/AMD-APP-SDK-v${version}-lnx64.tgz";
    sha256 = "d9c120367225bb1cd21abbcf77cb0a69cfb4bb6932d0572990104c566aab9681";
  } else if stdenv.system == "i686-linux" then fetchurl {
    url = "http://developer.amd.com/wordpress/media/2012/11/AMD-APP-SDK-v${version}-lnx32.tgz";
    sha256 = "99610737f21b2f035e0eac4c9e776446cc4378a614c7667de03a82904ab2d356";
  } else
    throw "System not supported";

  bits = if stdenv.system == "x86_64-linux" then "64"
         else "32";

  arch = if stdenv.system == "x86_64-linux" then "x86_64"
         else "i686";

  # TODO: Add optional aparapi support
  patches = [ ./01-remove-aparapi-samples.patch ];

  patchFlags = "-p0";
  buildInputs = [ makeWrapper perl mesa xorg.libX11 xorg.libXext xorg.libXaw xorg.libXi ];
  NIX_LDFLAGS = "-lX11 -lXext -lXmu -lXi";
  doCheck = false;

  unpackPhase = ''
    tar xvzf $src
    tar xf AMD-APP-SDK-v${version}-RC-lnx${bits}.tgz
    cd AMD-APP-SDK-v${version}-RC-lnx${bits}
  '';

  installPhase = ''
    #Install SDK
    mkdir -p $out
    cp -r {docs,include} "$out/"
    mkdir -p "$out/"{bin,lib,samples/opencl/bin}
    cp -r "./bin/${arch}/clinfo" "$out/bin/clinfo"
    cp -r "./lib/${arch}/"* "$out/lib/"
    find ./samples/opencl/ -mindepth 1 -maxdepth 1 -type d -not -name bin -exec cp -r {} "$out/samples/opencl" \;
    cp -r "./samples/opencl/bin/${arch}/"* "$out/samples/opencl/bin"

    #Register ICD
    mkdir -p "$out/etc/OpenCL/vendors"
    echo "$out/lib/libamdocl${bits}.so" > "$out/etc/OpenCL/vendors/amd.icd"
    # The OpenCL ICD specifications: http://www.khronos.org/registry/cl/extensions/khr/cl_khr_icd.txt

    #Install includes
    mkdir -p "$out/usr/include/"{CAL,OpenVideo}
    install -m644 './include/OpenVideo/'{OVDecode.h,OVDecodeTypes.h} "$out/usr/include/OpenVideo/"

    #Create wrappers
    wrapProgram "$out/bin/clinfo" --prefix LD_LIBRARY_PATH ":" "$out/lib"

    #Fix modes
    find "$out/" -type f -exec chmod 644 {} \;
    chmod -R 755 "$out/bin/"
    find "$out/samples/opencl/bin" -type f -not -name "*.*" -exec chmod 755 {} \;
  '';

  meta = {
    description = "AMD Accelerated Parallel Processing (APP) SDK, with OpenCL 1.2 support";
    homepage = http://developer.amd.com/tools/heterogeneous-computing/amd-accelerated-parallel-processing-app-sdk/;
    license = "unfree";
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}
