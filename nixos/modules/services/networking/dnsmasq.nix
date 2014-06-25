{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.dnsmasq;
  dnsmasq = pkgs.dnsmasq;

  serversParam = concatMapStrings (s: "-S ${s} ") cfg.servers;

  dnsmasqConf = pkgs.writeText "dnsmasq.conf" ''
    user=dnsmasq
    group=nogroup
    ${cfg.extraConfig}
  '';

in

{

  ###### interface

  options = {

    services.dnsmasq = {

      enable = mkOption {
        default = false;
        description = ''
          Whether to run dnsmasq.
        '';
      };

      servers = mkOption {
        default = [];
        example = [ "8.8.8.8" "8.8.4.4" ];
        description = ''
          The parameter to dnsmasq -S.
        '';
      };

      extraConfig = mkOption {
        type = types.string;
        default = "";
        description = ''
          Extra configuration directives that should be added to
          <literal>dnsmasq.conf</literal>
        '';
      };

    };

  };


  ###### implementation

  config = mkIf config.services.dnsmasq.enable {

    users = {
      extraUsers.dnsmasq = {
        uid = config.ids.uids.dnsmasq;
        description = "Dnsmasq daemon user";
      };
    };

    jobs.dnsmasq =
      { description = "dnsmasq daemon";

        startOn = "ip-up";

        daemonType = "daemon";

        exec = "${dnsmasq}/bin/dnsmasq -R ${serversParam} -o -C ${dnsmasqConf}";
      };

  };

}
