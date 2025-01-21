{
  lib,
  config,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.module.defaults;
in
{
  options.module.defaults = {
    # Defaults
    terminal = mkOption {
      type = types.enum [
        "foot"
        "alacritty"
      ];

      default = "foot";
    };

    appLauncher = mkOption {
      type = types.enum [
        "wofi"
        "rofi"
        "rofi-wayland"
        "fuzzel"
      ];

      default = "rofi-wayland";
    };

    browser = mkOption {
      type = types.enum [
        "librewolf"
        "firefox"
        "chromium"
      ];

      default = "librewolf";
    };

    # Defaults cmds
    terminalCmd = mkOption {
      type = types.str;
      default = "${pkgs.${cfg.terminal}}/bin/${cfg.terminal}";
    };

    browserCmd =

      let
        browserExecs = {
          librewolf = "${pkgs.librewolf}/bin/librewolf";
          firefox = "${pkgs.firefox}/bin/firefox";
          chromium = "${pkgs.ungoogled-chromium}/bin/chromium";
        };
      in
      mkOption {
        type = types.str;
        default = browserExecs.${cfg.browser};
      };

    appLauncherCmd =
      let
        appLauncherExecs = {
          rofi = "${pkgs.rofi}/bin/rofi -show drun";
          rofi-wayland = "${pkgs.rofi-wayland}/bin/rofi -show drun";
          wofi = "${pkgs.wofi}/wofi --show drun";
          fuzzel = "${pkgs.fuzzel}/fuzzel --show drun";
        };
      in
      mkOption {
        type = types.str;
        default = appLauncherExecs.${cfg.appLauncher};
      };

    audioControlCmd = mkOption {
      type = types.str;
      default = "${pkgs.pulseaudio}/bin/pactl";
    };

    brightnessControlCmd = mkOption {
      type = types.str;
      default = "${pkgs.brightnessctl}/bin/brightnessctl";
    };

    clipHistCmd = mkOption {
      type = types.str;
      default = "${pkgs.cliphist}/bin/cliphist list | ${cfg.appLauncherCmd} -d | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy";
    };

    notificationsAppCmd = mkOption {
      type = types.str;
      default = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
    };

    ssh = {
      pubKeys = mkOption {
        type = types.listOf types.str;
        default = [ ];
      };
    };

    network = {
      iface = mkOption {
        type = types.str;
        default = "";
      };

      ip = mkOption {
        type = types.str;
        default = "";
      };

      gw = mkOption {
        type = types.str;
        default = "";
      };

      mask = mkOption {
        type = types.str;
        default = "";
      };

      cidr = mkOption {
        type = types.str;
        default = "";
      };
    };
  };
}
