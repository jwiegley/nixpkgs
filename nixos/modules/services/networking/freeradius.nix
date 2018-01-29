{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.freeradius;

    freeradiusService = cfg: optionalAttrs cfg.enable {
    freeradius = {
      description = "FreeRadius server";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      requires = ["network-online.target"];
      preStart = ''
        ${cfg.configDir}/certs/bootstrap
        ${pkgs.freeradius}/bin/radiusd -C -d ${cfg.configDir} -l stdout
      '';

      serviceConfig = {
          ExecStart = "${pkgs.freeradius}/bin/radiusd -f -d ${cfg.configDir} -l stdout -xx";
          ExecReload = [
            "${pkgs.freeradius}/bin/radiusd -C -d ${cfg.configDir}  -l stdout"
            "${pkgs.coreutils}/bin/kill -HUP $MAINPID"
          ];
          User = "radius";
      };
    };
  };

  freeradiusConfig = {

    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the freeradius server.
      '';
    };

    configDir = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = ''
        The path of the freeradius server configuration directory.
      '';
    };

  };

in

{

  ###### interface

  options = {
    services.freeradius = freeradiusConfig;
  };


  ###### implementation

  config = mkIf (cfg.enable) {

    users = {
      extraUsers.radius = {
        /*uid = config.ids.uids.radius;*/
        description = "Radius daemon user";
      };
    };

    systemd.services = freeradiusService cfg;

  };

}
