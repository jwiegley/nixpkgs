{ config, lib, pkgs, ... }:

with lib;

let

  smbToString = x: if builtins.typeOf x == "bool"
                   then boolToString x
                   else toString x;

  cfg = config.services.samba;

  samba = cfg.package;

  setupScript =
    ''
      mkdir -p /var/lock/samba /var/log/samba /var/cache/samba /var/lib/samba/private
    '';

  shareConfig = name:
    let share = getAttr name cfg.shares; in
    "[${name}]\n " + (smbToString (
       map
         (key: "${key} = ${smbToString (getAttr key share)}\n")
         (attrNames share)
    ));

  configFile = pkgs.writeText "smb.conf"
    (if cfg.configText != null then cfg.configText else
    ''
      [global]
      security = ${cfg.securityType}
      passwd program = /run/wrappers/bin/passwd %u
      pam password change = ${smbToString cfg.syncPasswordsByPam}
      invalid users = ${smbToString cfg.invalidUsers}

      ${cfg.extraConfig}

      ${smbToString (map shareConfig (attrNames cfg.shares))}
    '');

  # This may include nss_ldap, needed for samba if it has to use ldap.
  nssModulesPath = config.system.nssModules.path;

  daemonService = appName: args:
    { description = "Samba Service Daemon ${appName}";

      requiredBy = [ "samba.target" ];
      partOf = [ "samba.target" ];

      environment = {
        LD_LIBRARY_PATH = nssModulesPath;
        LOCALE_ARCHIVE = "/run/current-system/sw/lib/locale/locale-archive";
      };

      serviceConfig = {
        ExecStart = "${samba}/sbin/${appName} ${args}";
        ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
        LimitNOFILE = 16384;
        Type = "notify";
      };

      restartTriggers = [ configFile ];
    };

in

{

  ###### interface

  options = {

    # !!! clean up the descriptions.

    services.samba = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable Samba, which provides file and print
          services to Windows clients through the SMB/CIFS protocol.

          <note>
            <para>If you use the firewall consider adding the following:</para>
            <programlisting>
              networking.firewall.allowedTCPPorts = [ 139 445 ];
              networking.firewall.allowedUDPPorts = [ 137 138 ];
            </programlisting>
          </note>
        '';
      };

      enableNmbd = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether to enable Samba's nmbd, which replies to NetBIOS over IP name
          service requests. It also participates in the browsing protocols
          which make up the Windows "Network Neighborhood" view.
        '';
      };

      enableWinbindd = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether to enable Samba's winbindd, which provides a number of services
          to the Name Service Switch capability found in most modern C libraries,
          to arbitrary applications via PAM and ntlm_auth and to Samba itself.
        '';
      };

      package = mkOption {
        type = types.package;
        default = pkgs.samba;
        defaultText = "pkgs.samba";
        example = literalExample "pkgs.samba3";
        description = ''
          Defines which package should be used for the samba server.
        '';
      };

      syncPasswordsByPam = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enabling this will add a line directly after pam_unix.so.
          Whenever a password is changed the samba password will be updated as well.
          However, you still have to add the samba password once, using smbpasswd -a user.
          If you don't want to maintain an extra password database, you still can send plain text
          passwords which is not secure.
        '';
      };

      invalidUsers = mkOption {
        type = types.listOf types.str;
        default = [ "root" ];
        description = ''
          List of users who are denied to login via Samba.
        '';
      };

      extraConfig = mkOption {
        type = types.lines;
        default = "";
        description = ''
          Additional global section and extra section lines go in here.
        '';
        example = ''
          guest account = nobody
          map to guest = bad user
        '';
      };

      configText = mkOption {
        type = types.nullOr types.lines;
        default = null;
        description = ''
          Verbatim contents of smb.conf. If null (default), use the
          autogenerated file from NixOS instead.
        '';
      };

      securityType = mkOption {
        type = types.str;
        default = "user";
        example = "share";
        description = "Samba security type";
      };

      nsswins = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Whether to enable the WINS NSS (Name Service Switch) plug-in.
          Enabling it allows applications to resolve WINS/NetBIOS names (a.k.a.
          Windows machine names) by transparently querying the winbindd daemon.
        '';
      };

      shares = mkOption {
        default = {};
        description = ''
          A set describing shared resources.
          See <command>man smb.conf</command> for options.
        '';
        type = types.attrsOf (types.attrsOf types.unspecified);
        example =
          { public =
            { path = "/srv/public";
              "read only" = true;
              browseable = "yes";
              "guest ok" = "yes";
              comment = "Public samba share.";
            };
          };
      };

    };

  };


  ###### implementation

  config = mkMerge
    [ { assertions =
          [ { assertion = cfg.nsswins -> cfg.enableWinbindd;
              message   = "If samba.nsswins is enabled, then samba.enableWinbindd must also be enabled";
            }
          ];
        # Always provide a smb.conf to shut up programs like smbclient and smbspool.
        environment.etc = singleton
          { source =
              if cfg.enable then configFile
              else pkgs.writeText "smb-dummy.conf" "# Samba is disabled.";
            target = "samba/smb.conf";
          };
      }

      (mkIf cfg.enable {

        system.nssModules = optional cfg.nsswins samba;

        systemd = {
          targets.samba = {
            description = "Samba Server";
            requires = [ "samba-setup.service" ];
            after = [ "samba-setup.service" "network.target" ];
            wantedBy = [ "multi-user.target" ];
          };

          services = {
            "samba-smbd" = daemonService "smbd" "-F";
            "samba-nmbd" = mkIf cfg.enableNmbd (daemonService "nmbd" "-F");
            "samba-winbindd" = mkIf cfg.enableWinbindd (daemonService "winbindd" "-F");
            "samba-setup" = {
              description = "Samba Setup Task";
              script = setupScript;
              unitConfig.RequiresMountsFor = "/var/lib/samba";
            };
          };
        };

        security.pam.services.samba = {};

      })
    ];

}
