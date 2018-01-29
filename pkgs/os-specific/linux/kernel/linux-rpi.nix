{ stdenv, buildPackages, hostPlatform, fetchFromGitHub, perl, buildLinux, ... } @ args:

let
  modDirVersion = "4.9.59";
  tag = "1.20171029";
in
stdenv.lib.overrideDerivation (buildLinux (args // rec {
  version = "${modDirVersion}-${tag}";
  inherit modDirVersion;

  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "linux";
    rev = "raspberrypi-kernel_${tag}-1";
    sha256 = "19lb1gxz21x1d5zdznzqfq60kxg7iqmyl6l0mb9qg2vrl8fcgnxk";
  };

  features = {
    efiBootStub = false;
  } // (args.features or {});

  extraMeta.hydraPlatforms = [];
})) (oldAttrs: {
  postConfigure = ''
    # The v7 defconfig has this set to '-v7' which screws up our modDirVersion.
    sed -i $buildRoot/.config -e 's/^CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION=""/'
  '';

  postFixup = ''
    # Make copies of the DTBs so that U-Boot finds them, as it is looking for the upstream names.
    # This is ugly as heck.
    copyDTB() {
      if [ -f "$out/dtbs/$1" ]; then
        cp -v "$out/dtbs/$1" "$out/dtbs/$2"
      fi
    }

    # I am not sure if all of these are correct...
    copyDTB bcm2708-rpi-0-w.dts bcm2835-rpi-zero.dtb
    copyDTB bcm2708-rpi-b.dtb bcm2835-rpi-a.dtb
    copyDTB bcm2708-rpi-b.dtb bcm2835-rpi-b.dtb
    copyDTB bcm2708-rpi-b.dtb bcm2835-rpi-b-rev2.dtb
    copyDTB bcm2708-rpi-b-plus.dtb bcm2835-rpi-a-plus.dtb
    copyDTB bcm2708-rpi-b-plus.dtb bcm2835-rpi-b-plus.dtb
    copyDTB bcm2708-rpi-b-plus.dtb bcm2835-rpi-zero.dtb
    copyDTB bcm2708-rpi-cm.dtb bcm2835-rpi-cm.dtb
    copyDTB bcm2709-rpi-2-b.dtb bcm2836-rpi-2-b.dtb
    copyDTB bcm2710-rpi-3-b.dtb bcm2837-rpi-3-b.dtb
    # bcm2710-rpi-cm3.dts is yet unknown.
  '';
})
