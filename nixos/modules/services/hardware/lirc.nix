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
        description = "Configuration to load.";
      };

      extraArguments = mkOption {
        type = types.str;
        default = "";
        description = "Extra arguments to lircd.";
      };

    };
  };

  ###### implementation

  config = mkIf cfg.enable {

    # Note: LIRC executables raises a warning, if lirc_options.conf do not exists
    environment.etc."lirc/lirc_options.conf".text = cfg.options;

    environment.systemPackages = [ pkgs.lirc ];

    system.activationScripts.lirc = ''
      umask 027
      mkdir -p /var/run/lirc
      chown -R lirc:lirc /var/run/lirc
    '';

    systemd.sockets.lircd = {
      description = "LIRC";
      wantedBy = [ "sockets.target" ];
      socketConfig = {
        ListenStream = "/var/run/lirc/lircd";
        SocketUser = "lirc";
        SocketMode = "0660";
      };
    };

    systemd.services.lircd = let
      configFile = pkgs.writeText "lircd.conf" cfg.config;
    in {
      description = "LIRC daemon service";
      after = [ "network.target" ];

      unitConfig.Documentation = [ "man:lircd(8)" ];

      serviceConfig = {
        ExecStart = "${pkgs.lirc}/bin/lircd --nodaemon ${cfg.extraArguments} ${configFile}";
        User = "lirc";
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
