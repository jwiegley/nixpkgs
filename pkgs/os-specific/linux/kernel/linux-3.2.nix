{ stdenv, fetchurl, apparmor-kernel-patches, ... } @ args:

import ./generic.nix (args // rec {
  version = "3.2.68";
  extraMeta.branch = "3.2";

  src = fetchurl {
    url = "mirror://kernel/linux/kernel/v3.x/linux-${version}.tar.xz";
    sha256 = "0yz3k3qqr13r6fa2f8i83rryiawy4rrd7qk2zx6jxq6byfd31ba2";
  };

  # We don't provide these patches if grsecurity is enabled, because
  # the grsec 3.2 -stable patchset already includes them.
  kernelPatches = args.kernelPatches ++ (
    stdenv.lib.optionals (!(args.features.grsecurity or false))
      [ rec { name  = "0001-AppArmor-compatibility-patch-for-v5-network-controll";
              patch = "${apparmor-kernel-patches}/${extraMeta.branch}/${name}.patch";
            }
        rec { name  = "0002-AppArmor-compatibility-patch-for-v5-interface";
              patch = "${apparmor-kernel-patches}/${extraMeta.branch}/${name}.patch";
            }
        rec { name  = "0003-AppArmor-Allow-dfa-backward-compatibility-with-broke";
              patch = "${apparmor-kernel-patches}/${extraMeta.branch}/${name}.patch";
            }
      ]);

  features.iwlwifi  = true;
} // (args.argsOverride or {}))
