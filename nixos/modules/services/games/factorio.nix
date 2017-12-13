{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.factorio;
  factorio = pkgs.factorio-headless;
  name = "Factorio";
  stateDir = cfg.stateDir;
  mkSavePath = name: "${stateDir}/saves/${name}.zip";
  configFile = pkgs.writeText "factorio.conf" ''
    use-system-read-write-data-directories=true
    [path]
    read-data=${factorio}/share/factorio/data
    write-data=${stateDir}
  '';
  serverSettings = {
    name = cfg.game-name;
    description = cfg.description;
    visibility = {
      public = cfg.public;
      lan = cfg.lan;
    };
    username = cfg.username;
    password = cfg.password;
    token = cfg.token;
    game_password = cfg.game-password;
    require_user_verification = cfg.requireUserVerification;
    max_upload_in_kilobytes_per_second = 0;
    minimum_latency_in_ticks = 0;
    ignore_player_limit_for_returning_players = false;
    allow_commands = "admins-only";
    autosave_interval = cfg.autosave-interval;
    autosave_slots = 5;
    afk_autokick_interval = 0;
    auto_pause = true;
    only_admins_can_pause_the_game = true;
    autosave_only_on_server = true;
    admins = [];
  };
  serverSettingsFile = pkgs.writeText "server-settings.json" (builtins.toJSON (filterAttrsRecursive (n: v: v != null) serverSettings));
  modDir = pkgs.factorio-utils.mkModDirDrv cfg.mods;
in
{
  options = {
    services.factorio = {
      enable = mkEnableOption name;
      port = mkOption {
        type = types.int;
        default = 34197;
        description = ''
          The port to which the service should bind.

          This option will also open up the UDP port in the firewall configuration.
        '';
      };
      saveName = mkOption {
        type = types.string;
        default = "default";
        description = ''
          The name of the savegame that will be used by the server.

          When not present in ${stateDir}/saves, a new map with default
          settings will be generated before starting the service.
        '';
      };
      # TODO Add more individual settings as nixos-options?
      # TODO XXX The server tries to copy a newly created config file over the old one
      #   on shutdown, but fails, because it's in the nix store. When is this needed?
      #   Can an admin set options in-game and expect to have them persisted?
      configFile = mkOption {
        type = types.path;
        default = configFile;
        defaultText = "configFile";
        description = ''
          The server's configuration file.

          The default file generated by this module contains lines essential to
          the server's operation. Use its contents as a basis for any
          customizations.
        '';
      };
      stateDir = mkOption {
        type = types.path;
        default = "/var/lib/factorio";
        description = ''
          The server's data directory.

          The configuration and map will be stored here.
        '';
      };
      mods = mkOption {
        type = types.listOf types.package;
        default = [];
        description = ''
          Mods the server should install and activate.

          The derivations in this list must "build" the mod by simply copying
          the .zip, named correctly, into the output directory. Eventually,
          there will be a way to pull in the most up-to-date list of
          derivations via nixos-channel. Until then, this is for experts only.
        '';
      };
      game-name = mkOption {
        type = types.nullOr types.string;
        default = "Factorio Game";
        description = ''
          Name of the game as it will appear in the game listing.
        '';
      };
      description = mkOption {
        type = types.nullOr types.string;
        default = "";
        description = ''
          Description of the game that will appear in the listing.
        '';
      };
      public = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Game will be published on the official Factorio matching server.
        '';
      };
      lan = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Game will be broadcast on LAN.
        '';
      };
      username = mkOption {
        type = types.nullOr types.string;
        default = null;
        description = ''
          Your factorio.com login credentials. Required for games with visibility public.
        '';
      };
      password = mkOption {
        type = types.nullOr types.string;
        default = null;
        description = ''
          Your factorio.com login credentials. Required for games with visibility public.
        '';
      };
      token = mkOption {
        type = types.nullOr types.string;
        default = null;
        description = ''
          Authentication token. May be used instead of 'password' above.
        '';
      };
      game-password = mkOption {
        type = types.nullOr types.string;
        default = null;
        description = ''
          Game password.
        '';
      };
      requireUserVerification = mkOption {
        type = types.bool;
        default = true;
        description = ''
          When set to true, the server will only allow clients that have a valid factorio.com account.
        '';
      };
      autosave-interval = mkOption {
        type = types.nullOr types.int;
        default = null;
        example = 10;
        description = ''
          Autosave interval in minutes.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    users = {
      users.factorio = {
        uid             = config.ids.uids.factorio;
        description     = "Factorio server user";
        group           = "factorio";
        home            = stateDir;
        createHome      = true;
      };

      groups.factorio = {
        gid = config.ids.gids.factorio;
      };
    };

    systemd.services.factorio = {
      description   = "Factorio headless server";
      wantedBy      = [ "multi-user.target" ];
      after         = [ "network.target" ];

      preStart = toString [
        "test -e ${stateDir}/saves/${cfg.saveName}.zip"
        "||"
        "${factorio}/bin/factorio"
          "--config=${cfg.configFile}"
          "--create=${mkSavePath cfg.saveName}"
          (optionalString (cfg.mods != []) "--mod-directory=${modDir}")
      ];

      serviceConfig = {
        User = "factorio";
        Group = "factorio";
        Restart = "always";
        KillSignal = "SIGINT";
        WorkingDirectory = stateDir;
        PrivateTmp = true;
        UMask = "0007";
        ExecStart = toString [
          "${factorio}/bin/factorio"
          "--config=${cfg.configFile}"
          "--port=${toString cfg.port}"
          "--start-server=${mkSavePath cfg.saveName}"
          "--server-settings=${serverSettingsFile}"
          (optionalString (cfg.mods != []) "--mod-directory=${modDir}")
        ];
      };
    };

    networking.firewall.allowedUDPPorts = [ cfg.port ];
  };
}
