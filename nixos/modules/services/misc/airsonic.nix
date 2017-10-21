{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.airsonic;
in {
  options = {

    services.airsonic = {
      enable = mkEnableOption "Airsonic, the Free and Open Source media streaming server (fork of Subsonic and Libresonic)";

      user = mkOption {
        type = types.str;
        default = "airsonic";
        description = "User account under which airsonic runs.";
      };

      home = mkOption {
        type = types.path;
        default = "/var/lib/airsonic";
        description = ''
          The directory where Airsonic will create files.
          Make sure it is writable.
        '';
      };

      listenAddress = mkOption {
        type = types.string;
        default = "127.0.0.1";
        description = ''
          The host name or IP address on which to bind Airsonic.
          Only relevant if you have multiple network interfaces and want
          to make Airsonic available on only one of them. The default value
          will bind Airsonic to all available network interfaces.
        '';
      };

      port = mkOption {
        type = types.int;
        default = 4040;
        description = ''
          The port on which Airsonic will listen for
          incoming HTTP traffic. Set to 0 to disable.
        '';
      };

      contextPath = mkOption {
        type = types.path;
        default = "/";
        description = ''
          The context path, i.e., the last part of the Airsonic
          URL. Typically '/' or '/airsonic'. Default '/'
        '';
      };

      maxMemory = mkOption {
        type = types.int;
        default = 100;
        description = ''
          The memory limit (max Java heap size) in megabytes.
          Default: 100
        '';
      };

      transcoders = mkOption {
        type = types.listOf types.path;
        default = [ "${pkgs.ffmpeg.bin}/bin/ffmpeg" ];
        defaultText= [ "\${pkgs.ffmpeg.bin}/bin/ffmpeg" ];
        description = ''
          List of paths to transcoder executables that should be accessible
          from Airsonic. Symlinks will be created to each executable inside
          ${cfg.home}/transcoders.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.airsonic = {
      description = "Airsonic Media Server";
      after = [ "local-fs.target" "network.target" ];
      wantedBy = [ "multi-user.target" ];

      preStart = ''
        # Install transcoders.
        rm -rf ${cfg.home}/transcode
        mkdir -p ${cfg.home}/transcode
        for exe in ${toString cfg.transcoders}; do
          ln -sf "$exe" ${cfg.home}/transcode
        done
      '';
      serviceConfig = {
        ExecStart = ''
          ${pkgs.jre}/bin/java -Xmx${toString cfg.maxMemory}m \
          -Dairsonic.home=${cfg.home} \
          -Dserver.address=${cfg.listenAddress} \
          -Dserver.port=${toString cfg.port} \
          -Dairsonic.contextPath=${cfg.contextPath} \
          -Djava.awt.headless=true \
          -verbose:gc \
          -jar ${pkgs.airsonic}/webapps/airsonic.war
        '';
        Restart = "always";
        User = "airsonic";
        UMask = "0022";
      };
    };

    users.extraUsers.airsonic = {
      description = "Airsonic service user";
      name = cfg.user;
      home = cfg.home;
      createHome = true;
    };
  };
}
