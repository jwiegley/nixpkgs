# flatpak service.
{ config, lib, pkgs, ... }:

with lib;

{
  ###### interface
  options = {
    services.flatpak = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable flatpak service.
        '';
      };
    };
  };


  ###### implementation
  config = mkIf config.services.flatpak.enable {
    environment.systemPackages = [ pkgs.flatpak ];

    services.dbus.packages = [ pkgs.flatpak ];

    systemd.packages = [ pkgs.flatpak ];
  };
}
