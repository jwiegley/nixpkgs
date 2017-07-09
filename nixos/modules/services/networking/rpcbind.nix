{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.rpcbind;

in {

  ###### interface

  options = {

    services.rpcbind = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable `rpcbind', an ONC RPC directory service
          notably used by NFS and NIS, and which can be queried
          using the rpcinfo(1) command. `rpcbind` is a replacement for
          `portmap`.
        '';
      };

      insecure = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to run `rpcbind' in an insecure mode.
        '';
      };

    };

  };


  ###### implementation

  config = mkIf config.services.rpcbind.enable {
    environment.systemPackages = [ pkgs.rpcbind ];

    systemd.packages = [ pkgs.rpcbind ];

    systemd.services.rpcbind = {
      serviceConfig = {
        Environment = optionalString cfg.insecure ''
          RPCBIND_OPTIONS=-i
        '';
      };
      wantedBy = [ "multi-user.target" ];
    };

    users.extraUsers.rpc = {
      group = "nogroup";
      uid = config.ids.uids.rpc;
    };
  };

}
