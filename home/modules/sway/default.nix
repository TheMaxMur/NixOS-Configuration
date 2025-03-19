{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.sway;
in {
  imports = [
    "${self}/home/modules/sway/keybinds"
  ];

  options.module.sway = {
    enable = mkEnableOption "Enable sway";
  };

  config = mkIf cfg.enable {
    module.sway = {
      keybindings.enable = cfg.enable;
    };

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_DESKTOP = "sway";
      GTK_CSD = 0;
    };

    gtk = {
      gtk3.extraConfig = {
        gtk-decoration-layout = ":";
      };
    };

    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.sway;

      config = {
        focus.mouseWarping = "container";

        input = {
          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "0.3";
          };

          "type:keyboard" = {
            xkb_layout = "us,ru";
            xkb_options = "grp:win_space_toggle,grp:alt_shift_toggle,grp:caps_toggle";
            repeat_delay = "300";
            repeat_rate = "60";
          };

          "type:touchpad" = {
            natural_scroll = "enabled";
            tap = "enabled";
            click_method = "button_areas";
          };
        };

        gaps = {
          inner = 7;
        };

        bars = [];

        window = {
          titlebar = false;
        };

        startup = [
          {command = "${pkgs.blueman}/bin/blueman-applet";}
          {command = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store";}
          {command = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store";}
          {command = "${pkgs.sway}/bin/swaymsg 'workspace 1; exec ${pkgs.librewolf}/bin/librewolf'";}
          {
            command = "${pkgs.sway}/bin/swaymsg 'workspace 2; exec ${pkgs.telegram-desktop}/bin/telegram-desktop'";
          }
          {command = "${pkgs.sway}/bin/swaymsg 'workspace 4; exec ${pkgs.obsidian}/bin/obsidian'";}
          {command = "${pkgs.sway}/bin/swaymsg 'workspace 5; exec ${pkgs.foot}/bin/foot'";}
          {command = "${pkgs.sway}/bin/swaymsg 'workspace 5; exec ${pkgs.foot}/bin/foot'";}
          {command = "${pkgs.sway}/bin/swaymsg 'workspace 5; exec ${pkgs.foot}/bin/foot'";}
          {
            command = "${pkgs.sway}/bin/swaymsg 'workspace 6; exec ${pkgs.librewolf}/bin/librewolf -P Work'";
          }
        ];
      };
    };
  };
}
