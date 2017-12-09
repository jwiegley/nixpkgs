{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.lirc;
in {

  ###### interface

  options = {
    services.lirc = {

      enable = mkEnableOption "LIRC daemon";

      options = mkOption {
        type = types.lines;
        example = ''
          [lircd]
          nodaemon = False
        '';
        description = "LIRC default options (lirc_options.conf)";
      };

      config = mkOption {
        type = types.lines;
        description = "Configuration for lircd to load, see man:lircd.conf(5) for details";
      };

      extraArguments = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Extra arguments to lircd.";
      };

    };
  };

  ###### implementation

  config = mkIf cfg.enable {

    # Note: LIRC executables raises a warning, if lirc_options.conf do not exists
    environment.etc."lirc/lirc_options.conf".text = cfg.options;

    environment.systemPackages = [ pkgs.lirc ];

    systemd.services.lircd = let
      configFile = pkgs.writeText "lircd.conf" cfg.config;
    in {
      description = "LIRC daemon service";
      after = [ "network.target" ];

      unitConfig.Documentation = [ "man:lircd(8)" ];

      serviceConfig = {
        ExecStartPre = "${pkgs.coreutils}/bin/install -o lirc -g lirc -m 750 -d /run/lirc";
        ExecStart = ''
          ${pkgs.lirc}/bin/lircd --nodaemon \
            ${escapeShellArgs cfg.extraArguments} \
            ${configFile}
        '';
        User = "lirc";
        PermissionsStartOnly = true;
      };
    };

    users.users.lirc = {
      uid = config.ids.uids.lirc;
      group = "lirc";
      description = "LIRC user for lircd";
    };

    users.groups.lirc.gid = config.ids.gids.lirc;
  };
}
