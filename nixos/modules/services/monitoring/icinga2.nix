{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.icinga2;
  environment = pkgs.writeText "icinga-env" ''
    DAEMON=${lib.getBin pkgs.icinga2}/sbin/icinga2
    ICINGA2_CONFIG_FILE=/etc/icinga2/icinga2.conf
    ICINGA2_RUN_DIR=/run
    ICINGA2_STATE_DIR=/var/lib/icinga2
    ICINGA2_PID_FILE=$ICINGA2_RUN_DIR/icinga2/icinga2.pid
    ICINGA2_ERROR_LOG=$ICINGA2_STATE_DIR/error.log
    ICINGA2_STARTUP_LOG=$ICINGA2_STATE_DIR/startup.log
    ICINGA2_LOG=$ICINGA2_STATE_DIR/icinga2.log
    ICINGA2_USER=${cfg.user}
    ICINGA2_GROUP=${cfg.group}
    ICINGA2_COMMAND_GROUP=${cfg.cmdgroup}
  '';
in {
  ###### interface

  options = {

    services.icinga2 = {
      enable = mkEnableOption "icinga2";
      user = mkOption {
        type = types.str;
        default = "icinga";
        description = "User account under which icinga2 runs.";
      };
      group = mkOption {
        type = types.str;
        default = "icinga";
        description = "group under which icinga2 runs.";
      };
      cmdgroup = mkOption {
        type = types.str;
        default = "icingacmd";
        description = "Command group for icinga2";
      };
    };
  };


  ###### implementation

  config = mkIf cfg.enable {


    users.extraUsers.icinga2 = {
      name = cfg.user;
      description = "icinga2 service user";
    };
    users.groups.icinga2 = {
      name = cfg.group;
    };
    users.groups.icingacmd = {
      name = cfg.cmdgroup;
    };

    systemd.services.icinga2 = {
      description = "icinga2 service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "forking";
        EnvironmentFile = environment;
        ExecStart = "${pkgs.icinga2}/bin/icinga2 daemon -d -D LocalStateDir=/var/lib/icinga2";
        ExecStartPre = "${pkgs.icinga2}/lib/icinga2/prepare-dirs ${environment}";
        ExecReload = "${pkgs.icinga2}/lib/icinga2/safe-reload ${environment}";
        PIDFile = "/run/icinga2/icinga2.pid";
        TimeoutStartSec="30m";
        RuntimeDirectory = "icinga2";
      };
    };
  };
}
