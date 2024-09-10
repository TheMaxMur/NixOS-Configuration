{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.sway.keybindings;
  super = "Mod4";

  workspace1  = "workspace number 1";
  workspace2  = "workspace number 2";
  workspace3  = "workspace number 3";
  workspace4  = "workspace number 4";
  workspace5  = "workspace number 5";
  workspace6  = "workspace number 6";
  workspace7  = "workspace number 7";
  workspace8  = "workspace number 8";
  workspace9  = "workspace number 9";
  workspace10 = "workspace number 10";
  workspace11 = "workspace number 11";
  workspace12 = "workspace number 12";

  terminal          = "${pkgs.foot}/bin/foot";
  screenshotArea    = "${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g - - | ${pkgs.wl-clipboard}/bin/wl-copy ";
  screenshotScreen  = "${pkgs.grim}/bin/grim -o $(swaymsg -t get_outputs | ${pkgs.jq}/bin/jq -r '.[] | select(.focused) | .name') - | ${pkgs.wl-clipboard}/bin/wl-copy";
  appLauncher       = "${pkgs.fuzzel}/bin/fuzzel -T ${terminal}";
  audioControl      = "${pkgs.pulseaudio}/bin/pactl";
  brightnessControl = "${pkgs.brightnessctl}/bin/brightnessctl";
  clipHist          = "${pkgs.cliphist}/bin/cliphist list | ${appLauncher} -d | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy";
  notificationsApp  = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
in {
  options.module.sway.keybindings = {
    enable = mkEnableOption "Enable sway keybindings";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway.config = {
      inherit terminal;
      modifier = super;

      assigns = {
        "2" = [ { app_id = "org.telegram.desktop"; } ];
        "4" = [ { app_id = "obsidian"; } ];
        "8" = [ { app_id = "vesktop"; } ];
      };

      keybindings = {
        # Terminal
        "--to-code ${super}+Return" = "exec ${terminal}";

        # Kill active window
        "--to-code ${super}+q" = "kill";

        # Change focus
        # Vim like
        "--to-code ${super}+h" = "focus left";
        "--to-code ${super}+j" = "focus down";
        "--to-code ${super}+k" = "focus up";
        "--to-code ${super}+l" = "focus right";

        # With arrows
        "--to-code ${super}+Left"  = "focus left";
        "--to-code ${super}+Down"  = "focus down";
        "--to-code ${super}+Up"    = "focus up";
        "--to-code ${super}+Right" = "focus right";

        # Move focused window
        # Vim like
        "--to-code ${super}+Shift+h" = "move left";
        "--to-code ${super}+Shift+j" = "move down";
        "--to-code ${super}+Shift+k" = "move up";
        "--to-code ${super}+Shift+l" = "move right";

        # With arrows
        "--to-code ${super}+Shift+Left"  = "move left";
        "--to-code ${super}+Shift+Down"  = "move down";
        "--to-code ${super}+Shift+Up"    = "move up";
        "--to-code ${super}+Shift+Right" = "move right";

        # Application launcher
        "--to-code Ctrl+Space" = "exec ${appLauncher}";
        "--to-code ${super}+c" = "exec ${clipHist}";

        # Multimedia keys
        "--to-code xf86audioraisevolume"  = "exec ${audioControl} set-sink-volume @DEFAULT_SINK@ +5%";
        "--to-code xf86audiolowervolume"  = "exec ${audioControl} set-sink-volume @DEFAULT_SINK@ -5%";
        "--to-code xf86audiomute"         = "exec ${audioControl} set-sink-mute @DEFAULT_SINK@ toggle";
        "--to-code XF86MonBrightnessDown" = "exec ${brightnessControl} set 5%-";
        "--to-code XF86MonBrightnessUp"   = "exec ${brightnessControl} set +5%";

        # Notifications
        "--to-code ${super}+n" = "exec ${notificationsApp}";

        # Screenshot
        "--to-code Print"       = "exec ${screenshotArea}";
        "--to-code Shift+Print" = "exec ${screenshotScreen}";

        # Reload the configuration file
        "--to-code ${super}+Shift+r" = "reload";

        # Fullscreen mode
        "--to-code ${super}+f" = "fullscreen";

        # Resize mode
        "--to-code ${super}+r" = "mode resize";

        # Layouts
        "--to-code ${super}+v" = "splitv";
        "--to-code ${super}+b" = "splith";
        "--to-code ${super}+s" = "layout toggle split";
        "--to-code ${super}+t" = "layout tabbed";

        # Switch to workspace using number row
        "--to-code ${super}+1"     = "${workspace1}";
        "--to-code ${super}+2"     = "${workspace2}";
        "--to-code ${super}+3"     = "${workspace3}";
        "--to-code ${super}+4"     = "${workspace4}";
        "--to-code ${super}+5"     = "${workspace5}";
        "--to-code ${super}+6"     = "${workspace6}";
        "--to-code ${super}+7"     = "${workspace7}";
        "--to-code ${super}+8"     = "${workspace8}";
        "--to-code ${super}+9"     = "${workspace9}";
        "--to-code ${super}+0"     = "${workspace10}";
        "--to-code ${super}+minus" = "${workspace11}";
        "--to-code ${super}+equal" = "${workspace12}";

        # Switch to scratchpad
        "--to-code ${super}+z" = "scratchpad show";

        # Move window to workspace using number row
        "--to-code ${super}+Shift+1"     = "move container to ${workspace1}";
        "--to-code ${super}+Shift+2"     = "move container to ${workspace2}";
        "--to-code ${super}+Shift+3"     = "move container to ${workspace3}";
        "--to-code ${super}+Shift+4"     = "move container to ${workspace4}";
        "--to-code ${super}+Shift+5"     = "move container to ${workspace5}";
        "--to-code ${super}+Shift+6"     = "move container to ${workspace6}";
        "--to-code ${super}+Shift+7"     = "move container to ${workspace7}";
        "--to-code ${super}+Shift+8"     = "move container to ${workspace8}";
        "--to-code ${super}+Shift+9"     = "move container to ${workspace9}";
        "--to-code ${super}+Shift+0"     = "move container to ${workspace10}";
        "--to-code ${super}+Shift+minus" = "move container to ${workspace11}";
        "--to-code ${super}+Shift+equal" = "move container to ${workspace12}";

        # Move window to scratchpad
        "--to-code ${super}+Shift+z" = "move scratchpad";
      };

      modes = {
        resize = {
          # Vim like binds
          "h" = "resize shrink width 10px";
          "j" = "resize shrink height 10px";
          "k" = "resize shrink height 10px";
          "l" = "resize shrink width 10px";

          # Arrows
          "Left"  = "resize shrink width 10px";
          "Down"  = "resize shrink height 10px";
          "Up"    = "resize shrink height 10px";
          "Right" = "resize shrink width 10px";

          # Vim like binds
          "Shift+h" = "resize grow width 10px";
          "Shift+j" = "resize grow height 10px";
          "Shift+k" = "resize grow height 10px";
          "Shift+l" = "resize grow width 10px";

          # Arrows
          "Shift+Left"  = "resize grow width 10px";
          "Shift+Down"  = "resize grow height 10px";
          "Shift+Up"    = "resize grow height 10px";
          "Shift+Right" = "resize grow width 10px";

          # Return to normal mode
          "Escape" = "mode default";
          "Return" = "mode default";
        };
      };
    };
  };
}

