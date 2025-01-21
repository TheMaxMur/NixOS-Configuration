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
        "fuzzel"
      ];

      default = "wofi";
    };

    browser = mkOption {
      type = types.enum [
        "librewolf"
        "firefox"
      ];

      default = "librewolf";
    };

    # Defaults cmds
    terminalCmd = mkOption {
      type = types.str;
      default = "${pkgs.${cfg.terminal}}/bin/${cfg.terminal}";
    };

    browserCmd = mkOption {
      type = types.str;
      default = "${pkgs.${cfg.browser}}/bin/${cfg.browser}";
    };

    appLauncherCmd = mkOption {
      type = types.str;
      default = "${pkgs.${cfg.appLauncher}}/bin/${cfg.appLauncher} --show drun";
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

