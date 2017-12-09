{ config, lib, pkgs, ... }:

with lib;

let
  xcfg = config.services.xserver;
  cfg = xcfg.desktopManager.cde;
in {
  options.services.xserver.desktopManager.cde = {
    enable = mkEnableOption "Common Desktop Environment";
  };

  config = mkIf (xcfg.enable && cfg.enable) {
    environment.systemPackages = [ pkgs.cdesktopenv ];

    services.rpcbind = {
      enable = true;
      insecure = true;
    };

    services.xserver.desktopManager.session = [
    { name = "CDE";
      start = ''
        export LD_LIBRARY_PATH="${pkgs.cdesktopenv}/opt/dt/usr/lib:$LD_LIBRARY_PATH"

        exec ${pkgs.cdesktopenv}/opt/dt/usr/bin/Xsession
      '';
    }];
  };

  meta.maintainers = [ maintainers.gnidorah ];
}
