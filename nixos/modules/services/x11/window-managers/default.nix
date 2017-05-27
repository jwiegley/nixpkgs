{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.xserver.windowManager;
in

{
  imports = [
    ./2bwm.nix
    ./afterstep.nix
    ./bspwm.nix
    ./compiz.nix
    ./dwm.nix
    ./exwm.nix
    ./fluxbox.nix
    ./fvwm.nix
    ./herbstluftwm.nix
    ./i3.nix
    ./jwm.nix
    ./metacity.nix
    ./mwm.nix
    ./openbox.nix
    ./pekwm.nix
    ./notion.nix
    ./ratpoison.nix
    ./sawfish.nix
    ./stumpwm.nix
    ./spectrwm.nix
    ./twm.nix
    ./windowmaker.nix
    ./wmii.nix
    ./xmonad.nix
    ./qtile.nix
    ./none.nix ];

  options = {

    services.xserver.windowManager = {

      session = mkOption {
        internal = true;
        default = [];
        example = [{
          name = "wmii";
          start = "...";
          bgSupport = true;
        }];
        description = ''
          Internal option used to add some common line to window manager
          scripts before forwarding the value to the
          <varname>displayManager</varname>.
        '';
        apply = map (d: d // {
          manage = "window";
          start = d.start
            + optionalString (d ? bgSupport && d.bgSupport)
              ''
                if [ -e $HOME/.background-image ]; then
                  ${pkgs.feh}/bin/feh --bg-scale $HOME/.background-image
                else
                  ${pkgs.xorg.xsetroot}/bin/xsetroot -solid black
                fi
              '';
        });
      };

      default = mkOption {
        type = types.str;
        default = "none";
        example = "wmii";
        description = "Default window manager loaded if none have been chosen.";
        apply = defaultWM:
          if any (w: w.name == defaultWM) cfg.session then
            defaultWM
          else
            throw "Default window manager (${defaultWM}) not found.";
      };

    };

  };

  config = {
    services.xserver.displayManager.session = cfg.session;
  };
}
