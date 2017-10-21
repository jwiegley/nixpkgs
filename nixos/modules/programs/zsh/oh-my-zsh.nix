{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.zsh.ohMyZsh;
in
  {
    options = {
      programs.zsh.ohMyZsh = {
        enable = mkOption {
          default = false;
          description = ''
            Enable oh-my-zsh.
          '';
        };

        package = mkOption {
          default = pkgs.oh-my-zsh;
          defaultText = "pkgs.oh-my-zsh";
          description = ''
            Package to install for `oh-my-zsh` usage.
          '';

          type = types.package;
        };

        plugins = mkOption {
          default = [];
          type = types.listOf(types.str);
          description = ''
            List of oh-my-zsh plugins
          '';
        };

        custom = mkOption {
          default = "";
          type = types.str;
          description = ''
            Path to a custom oh-my-zsh package to override config of oh-my-zsh.
          '';
        };

        theme = mkOption {
          default = "";
          type = types.str;
          description = ''
            Name of the theme to be used by oh-my-zsh.
          '';
        };
      };
    };

    config = mkIf cfg.enable {

      # Prevent zsh from overwriting oh-my-zsh's prompt
      programs.zsh.promptInit = mkDefault "";

      environment.systemPackages = [ cfg.package ];

      programs.zsh.interactiveShellInit = with builtins; ''
        # oh-my-zsh configuration generated by NixOS
        export ZSH=${cfg.package}/share/oh-my-zsh

        ${optionalString (length(cfg.plugins) > 0)
          "plugins=(${concatStringsSep " " cfg.plugins})"
        }

        ${optionalString (stringLength(cfg.custom) > 0)
          "ZSH_CUSTOM=\"${cfg.custom}\""
        }

        ${optionalString (stringLength(cfg.theme) > 0)
          "ZSH_THEME=\"${cfg.theme}\""
        }

        source $ZSH/oh-my-zsh.sh
      '';
    };
  }
