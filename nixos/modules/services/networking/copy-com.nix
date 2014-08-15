{ config, lib, pkgs, ... }:

with lib;

let
  
  cfg = config.services.copy-com;

in 

{
  options = {

    services.copy-com = {
	  
	  enable = mkOption {
          default = false;
          description = "
            Enable the copy.com client.
          ";
      };

      user = mkOption {
        description = "The user for which copy should run.";
      };

	};
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.postfix ];

    systemd.services."copy-com-${cfg.user}" = {
      description = "Copy.com Client";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.copy-com}/bin/copy_console";
        User = "${cfg.user}";
      };

    };
  };

}

