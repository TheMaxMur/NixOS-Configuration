{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.sway.keybindings;
  super = "Mod4";

  workspace1 = "workspace number 1";
  workspace2 = "workspace number 2";
  workspace3 = "workspace number 3";
  workspace4 = "workspace number 4";
  workspace5 = "workspace number 5";
  workspace6 = "workspace number 6";
  workspace7 = "workspace number 7";
  workspace8 = "workspace number 8";
  workspace9 = "workspace number 9";
  workspace10 = "workspace number 10";
  workspace11 = "workspace number 11";
  workspace12 = "workspace number 12";

  terminal = config.module.defaults.terminalCmd;
  appLauncher = config.module.defaults.appLauncherCmd;
  audioControl = config.module.defaults.audioControlCmd;
  brightnessControl = config.module.defaults.brightnessControlCmd;
  clipHist = config.module.defaults.clipHistCmd;
  notificationsApp = config.module.defaults.notificationsAppCmd;

  screenshotArea = "${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g - - | ${pkgs.wl-clipboard}/bin/wl-copy";
  screenshotScreen = "${pkgs.grim}/bin/grim -o $(swaymsg -t get_outputs | ${pkgs.jq}/bin/jq -r '.[] | select(.focused) | .name') - | ${pkgs.wl-clipboard}/bin/wl-copy";

  powerMenu = pkgs.writeShellScriptBin "powerMenu.sh" ''
    #!/usr/bin/env bash

    op=$(echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | ${pkgs.rofi-wayland}/bin/rofi -i -dmenu | ${pkgs.gawk}/bin/awk '{print tolower($2)}')

    case $op in
      poweroff)
        ;&
      reboot)
        ;&
      suspend)
        systemctl $op
        ;;
      lock)
        swaylock
        ;;
      logout)
        swaymsg exit
        ;;
    esac
  '';
in {
  options.module.sway.keybindings = {
    enable = mkEnableOption "Enable sway keybindings";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway.config = {
      inherit terminal;
      modifier = super;
      bindkeysToCode = true;

      assigns = {
        "2" = [{app_id = "org.telegram.desktop";}];
        "4" = [{app_id = "obsidian";}];
        "8" = [{app_id = "vesktop";}];
      };

      keybindings = {
        # Terminal
        "${super}+Return" = "exec ${terminal}";

        # Kill active window
        "${super}+q" = "kill";

        # PowerMenu
        "${super}+p" = "exec ${powerMenu}/bin/powerMenu.sh";

        # Change focus
        # Vim like
        "${super}+j" = "focus left";
        "${super}+k" = "focus down";
        "${super}+l" = "focus up";
        "${super}+apostrophe" = "focus right";

        # With arrows
        "${super}+Left" = "focus left";
        "${super}+Down" = "focus down";
        "${super}+Up" = "focus up";
        "${super}+Right" = "focus right";

        # Move focused window
        # Vim like
        "${super}+Shift+j" = "move left";
        "${super}+Shift+k" = "move down";
        "${super}+Shift+l" = "move up";
        "${super}+Shift+apostrophe" = "move right";

        # With arrows
        "${super}+Shift+Left" = "move left";
        "${super}+Shift+Down" = "move down";
        "${super}+Shift+Up" = "move up";
        "${super}+Shift+Right" = "move right";

        # Application launcher
        "${super}+d" = "exec ${appLauncher}";
        "${super}+c" = "exec ${clipHist}";

        # Multimedia keys
        "xf86audioraisevolume" = "exec ${audioControl} set-sink-volume @DEFAULT_SINK@ +5%";
        "xf86audiolowervolume" = "exec ${audioControl} set-sink-volume @DEFAULT_SINK@ -5%";
        "xf86audiomute" = "exec ${audioControl} set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86MonBrightnessDown" = "exec ${brightnessControl} set 5%-";
        "XF86MonBrightnessUp" = "exec ${brightnessControl} set +5%";

        # Notifications
        "${super}+n" = "exec ${notificationsApp}";

        # Screenshot
        "Print" = "exec ${screenshotArea}";
        "Shift+Print" = "exec ${screenshotScreen}";

        # Reload the configuration file
        "${super}+Shift+r" = "reload";

        # Fullscreen mode
        "${super}+f" = "fullscreen";

        # Float mode
        "${super}+Shift+f" = "floating toggle";

        # Resize mode
        "${super}+r" = "mode resize";

        # Layouts
        "${super}+v" = "splitv";
        "${super}+b" = "splith";
        "${super}+t" = "layout toggle split tabbed";
        "${super}+a" = "focus parent";

        # Switch to workspace using number row
        "${super}+1" = "${workspace1}";
        "${super}+2" = "${workspace2}";
        "${super}+3" = "${workspace3}";
        "${super}+4" = "${workspace4}";
        "${super}+5" = "${workspace5}";
        "${super}+6" = "${workspace6}";
        "${super}+7" = "${workspace7}";
        "${super}+8" = "${workspace8}";
        "${super}+9" = "${workspace9}";
        "${super}+0" = "${workspace10}";
        "${super}+minus" = "${workspace11}";
        "${super}+equal" = "${workspace12}";

        # Switch to scratchpad
        "${super}+z" = "scratchpad show";

        # Move window to workspace using number row
        "${super}+Shift+1" = "move container to ${workspace1}";
        "${super}+Shift+2" = "move container to ${workspace2}";
        "${super}+Shift+3" = "move container to ${workspace3}";
        "${super}+Shift+4" = "move container to ${workspace4}";
        "${super}+Shift+5" = "move container to ${workspace5}";
        "${super}+Shift+6" = "move container to ${workspace6}";
        "${super}+Shift+7" = "move container to ${workspace7}";
        "${super}+Shift+8" = "move container to ${workspace8}";
        "${super}+Shift+9" = "move container to ${workspace9}";
        "${super}+Shift+0" = "move container to ${workspace10}";
        "${super}+Shift+minus" = "move container to ${workspace11}";
        "${super}+Shift+equal" = "move container to ${workspace12}";

        # Move window to scratchpad
        "${super}+Shift+z" = "move scratchpad";
      };

      modes = {
        resize = {
          # Vim like binds
          "h" = "resize shrink width 10px";
          "j" = "resize shrink height 10px";
          "k" = "resize shrink height 10px";
          "l" = "resize shrink width 10px";

          # Arrows
          "Left" = "resize shrink width 10px";
          "Down" = "resize shrink height 10px";
          "Up" = "resize shrink height 10px";
          "Right" = "resize shrink width 10px";

          # Vim like binds
          "Shift+h" = "resize grow width 10px";
          "Shift+j" = "resize grow height 10px";
          "Shift+k" = "resize grow height 10px";
          "Shift+l" = "resize grow width 10px";

          # Arrows
          "Shift+Left" = "resize grow width 10px";
          "Shift+Down" = "resize grow height 10px";
          "Shift+Up" = "resize grow height 10px";
          "Shift+Right" = "resize grow width 10px";

          # Return to normal mode
          "Escape" = "mode default";
          "Return" = "mode default";
        };
      };
    };
  };
}
