{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.phpfpm;
  enabled = cfg.poolConfigs != {} || cfg.pools != {};

  stateDir = "/run/phpfpm";

  poolConfigs = cfg.poolConfigs // mapAttrs mkPool cfg.pools;

  mkPool = n: p: ''
    listen = ${p.listen}
    ${p.extraConfig}
  '';

  fpmCfgFile = pool: poolConfig: pkgs.writeText "phpfpm-${pool}.conf" ''
    [global]
    error_log = syslog
    daemonize = no
    ${cfg.extraConfig}

    [${pool}]
    ${poolConfig}
  '';

  phpIni = pkgs.runCommand "php.ini" {
    inherit (cfg) phpPackage phpOptions;
    nixDefaults = ''
      sendmail_path = "/run/wrappers/bin/sendmail -t -i"
    '';
    passAsFile = [ "nixDefaults" "phpOptions" ];
  } ''
    cat $phpPackage/etc/php.ini $nixDefaultsPath $phpOptionsPath > $out
  '';

in {

  options = {
    services.phpfpm = {
      extraConfig = mkOption {
        type = types.lines;
        default = "";
        description = ''
          Extra configuration that should be put in the global section of
          the PHP-FPM configuration file. Do not specify the options
          <literal>error_log</literal> or
          <literal>daemonize</literal> here, since they are generated by
          NixOS.
        '';
      };

      phpPackage = mkOption {
        type = types.package;
        default = pkgs.php;
        defaultText = "pkgs.php";
        description = ''
          The PHP package to use for running the PHP-FPM service.
        '';
      };

      phpOptions = mkOption {
        type = types.lines;
        default = "";
        example =
          ''
            date.timezone = "CET"
          '';
        description =
          "Options appended to the PHP configuration file <filename>php.ini</filename>.";
      };

      poolConfigs = mkOption {
        default = {};
        type = types.attrsOf types.lines;
        example = literalExample ''
          { mypool = '''
              listen = /run/phpfpm/mypool
              user = nobody
              pm = dynamic
              pm.max_children = 75
              pm.start_servers = 10
              pm.min_spare_servers = 5
              pm.max_spare_servers = 20
              pm.max_requests = 500
            ''';
          }
        '';
        description = ''
          A mapping between PHP-FPM pool names and their configurations.
          See the documentation on <literal>php-fpm.conf</literal> for
          details on configuration directives. If no pools are defined,
          the phpfpm service is disabled.
        '';
      };

      pools = mkOption {
        type = types.attrsOf (types.submodule (import ./pool-options.nix {
          inherit lib;
        }));
        default = {};
        example = literalExample ''
         {
           mypool = {
             listen = "/path/to/unix/socket";
             extraConfig = '''
               user = nobody
               pm = dynamic
               pm.max_children = 75
               pm.start_servers = 10
               pm.min_spare_servers = 5
               pm.max_spare_servers = 20
               pm.max_requests = 500
             ''';
           }
         }'';
        description = ''
          PHP-FPM pools. If no pools or poolConfigs are defined, the PHP-FPM
          service is disabled.
        '';
      };
    };
  };

  config = mkIf enabled {

    systemd.slices.phpfpm = {
      description = "PHP FastCGI Process manager pools slice";
    };

    systemd.targets.phpfpm = {
      description = "PHP FastCGI Process manager pools target";
      wantedBy = [ "multi-user.target" ];
    };

    systemd.services = flip mapAttrs' poolConfigs (pool: poolConfig:
      nameValuePair "phpfpm-${pool}" {
        description = "PHP FastCGI Process Manager service for pool ${pool}";
        after = [ "network.target" ];
        wantedBy = [ "phpfpm.target" ];
        partOf = [ "phpfpm.target" ];
        preStart = ''
          mkdir -p ${stateDir}
        '';
        serviceConfig = let
          cfgFile = fpmCfgFile pool poolConfig;
        in {
          Slice = "phpfpm.slice";
          PrivateTmp = true;
          PrivateDevices = true;
          ProtectSystem = "full";
          ProtectHome = true;
          NoNewPrivileges = true;
          RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6";
          Type = "notify";
          ExecStart = "${cfg.phpPackage}/bin/php-fpm -y ${cfgFile} -c ${phpIni}";
          ExecReload = "${pkgs.coreutils}/bin/kill -USR2 $MAINPID";
        };
      }
   );
  };

}
