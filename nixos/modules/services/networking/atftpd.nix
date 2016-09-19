# NixOS module for atftpd TFTP server

{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.services.atftpd;

in

{

  options = {

    services.atftpd = {

      enable = mkEnableOption "the atftpd TFTP server";

      root = mkOption {
        default = "/var/empty";
        type = types.str;
        description = ''
          Document root directory for the atftpd.
        '';
      };

    };

  };

  config = mkIf cfg.enable {

    systemd.services.atftpd = {
      description = "atftpd TFTP server";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      # runs as nobody
      serviceConfig.ExecStart = "${pkgs.atftp}/sbin/atftpd --daemon --no-fork --bind-address 0.0.0.0 ${cfg.root}";
    };

  };

}
