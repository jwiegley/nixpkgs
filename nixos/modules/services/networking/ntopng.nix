{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.ntopng;
  redisCfg = config.services.redis;

  configFile = if cfg.configText != "" then
    pkgs.writeText "ntopng.conf" ''
      ${cfg.configText}
    ''
    else
    pkgs.writeText "ntopng.conf" ''
      ${concatStringsSep " " (map (e: "--interface=" + e) cfg.interfaces)}
      --http-port=${toString cfg.http-port}
      --redis=localhost:${toString redisCfg.port}
      ${cfg.extraConfig}
    '';

in

{

  options = {

    services.ntopng = {

      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable ntopng, a high-speed web-based traffic analysis and flow
          collection tool.

          With the default configuration, ntopng monitors all network
          interfaces and displays its findings at http://localhost:${toString
          cfg.http-port}. Default username and password is admin/admin.

          See the ntopng(8) manual page and https://www.ntop.org/products/ntop/
          for more info.

          Note that enabling ntopng will also enable redis (key-value
          database server) for persistent data storage.
        '';
      };

      interfaces = mkOption {
        default = [ "any" ];
        example = [ "eth0" "wlan0" ];
        type = types.listOf types.str;
        description = ''
          List of interfaces to monitor. Use "any" to monitor all interfaces.
        '';
      };

      http-port = mkOption {
        default = 3000;
        type = types.int;
        description = ''
          Sets the HTTP port of the embedded web server.
        '';
      };

      configText = mkOption {
        default = "";
        example = ''
          --interface=any
          --http-port=3000
          --disable-login
        '';
        type = types.lines;
        description = ''
          Overridable configuration file contents to use for ntopng. By
          default, use the contents automatically generated by NixOS.
        '';
      };

      extraConfig = mkOption {
        default = "";
        type = types.lines;
        description = ''
          Configuration lines that will be appended to the generated ntopng
          configuration file. Note that this mechanism does not work when the
          manual <option>configText</option> option is used.
        '';
      };

    };

  };

  config = mkIf cfg.enable {

    # ntopng uses redis for data storage
    services.redis.enable = true;

    # nice to have manual page and ntopng command in PATH
    environment.systemPackages = [ pkgs.ntopng ];

    systemd.services.ntopng = {
      description = "Ntopng Network Monitor";
      requires = [ "redis.service" ];
      after = [ "network.target" "redis.service" ];
      wantedBy = [ "multi-user.target" ];
      preStart = "mkdir -p /var/lib/ntopng/";
      serviceConfig.ExecStart = "${pkgs.ntopng}/bin/ntopng ${configFile}";
      unitConfig.Documentation = "man:ntopng(8)";
    };

    # ntopng drops priveleges to user "nobody" and that user is already defined
    # in users-groups.nix.
  };

}
