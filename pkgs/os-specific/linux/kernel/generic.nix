{ stdenv, perl, buildLinux

, # The kernel source tarball.
  src

, # The kernel version.
  version

, # path to a .config file (or its content ?)
  # if it s null we generate it
  configfilename ? null

, # Appended verbatim to kernel .config
  extraConfig ? ""

, # The version number used for the module directory
  modDirVersion ? version

, # An attribute set whose attributes express the availability of
  # certain features in this kernel.  E.g. `{iwlwifi = true;}'
  # indicates a kernel that provides Intel wireless support.  Used in
  # NixOS to implement kernel-specific behaviour.
  features ? {}

, # A list of patches to apply to the kernel.  Each element of this list
  # should be an attribute set {name, patch} where `name' is a
  # symbolic name and `patch' is the actual patch.  The patch may
  # optionally be compressed with gzip or bzip2.
  kernelPatches ? []
, ignoreConfigErrors ? stdenv.platform.name != "pc"
, extraMeta ? {}
, hostPlatform
, callPackage
, ...
} @ args:

assert stdenv.isLinux;

let

  lib = stdenv.lib;

  # Combine the `features' attribute sets of all the kernel patches.
  kernelFeatures = lib.fold (x: y: (x.features or {}) // y) ({
    iwlwifi = true;
    efiBootStub = true;
    needsCifsUtils = true;
    netfilterRPFilter = true;
  } // features) kernelPatches;

  configWithPlatform = kernelPlatform: import ./common-config.nix {
    inherit stdenv version kernelPlatform extraConfig;
    features = kernelFeatures; # Ensure we know of all extra patches, etc.
  };

  config = configWithPlatform stdenv.platform;
  configCross = configWithPlatform hostPlatform.platform;

    configDrv = callPackage ./config.nix {
    inherit ignoreConfigErrors;

    inherit version src kernelPatches stdenv;
    # modDirVersion
    };

  # TODO moved it
  # callPackage ./config.nix {};
  # configfile = stdenv.mkDerivation {
  # configfile = (import ./config.nix);

    # TODO le transformer plutot en
  kernel = buildLinux {
    # TODO args
    inherit version modDirVersion src kernelPatches stdenv;
    # inherit ignoreConfigErrors;
    inherit configDrv;

    # configfile = configfile.nativeDrv or configfile;
    # configfile = configfile.nativeDrv or configfile;

    # this is really configfilename
    # configfile = if configfilename then configfilename else (callPackage ./config.nix {});
    configfile = null;


    # TODO fix later
    # crossConfigfile = configfile.crossDrv or configfile;

    config = { CONFIG_MODULES = "y"; CONFIG_FW_LOADER = "m"; };

    crossConfig = { CONFIG_MODULES = "y"; CONFIG_FW_LOADER = "m"; };
  };

  passthru = {
    features = kernelFeatures;

    meta = kernel.meta // extraMeta;

    passthru = kernel.passthru // (removeAttrs passthru [ "passthru" "meta" ]);
  };

  nativeDrv = lib.addPassthru kernel.nativeDrv passthru;

  crossDrv = lib.addPassthru kernel.crossDrv passthru;

in if kernel ? crossDrv
   then nativeDrv // { inherit nativeDrv crossDrv; }
   else lib.addPassthru kernel passthru
