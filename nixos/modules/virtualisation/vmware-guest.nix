{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.vmwareGuest;
  open-vm-tools = pkgs.open-vm-tools.override {
    kernel = if cfg.enableModules then config.boot.kernelPackages.kernel else null;
  };
in
{
  options = {
    services.vmwareGuest = { 
      enable = mkEnableOption "Enable VMWare Guest Support";

      enableModules = mkOption {
        default = false;
        description = "Enable kernel modules to support additional hardware and shared folders";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [ {
      assertion = pkgs.stdenv.isi686 || pkgs.stdenv.isx86_64;
      message = "VMWare guest is not currently supported on ${pkgs.stdenv.system}";
    } ];

    boot = mkIf cfg.enableModules {
       extraModulePackages = [ open-vm-tools ];
       kernelModules = [ "vmhgfs" ];
    };

    environment.systemPackages = [ open-vm-tools ];

    systemd.services.vmware =
      { description = "VMWare Guest Service";
        wantedBy = [ "multi-user.target" ];
        serviceConfig.ExecStart = "${open-vm-tools}/bin/vmtoolsd";
      };

    services.xserver = {
      videoDrivers = mkOverride 50 [ "vmware" ];

      config = ''
          Section "InputDevice"
            Identifier "VMMouse"
            Driver "vmmouse"
          EndSection
        '';

      serverLayoutSection = ''
          InputDevice "VMMouse"
        '';

      displayManager.sessionCommands = ''
          ${open-vm-tools}/bin/vmware-user-suid-wrapper
        '';
    };
  };
}
