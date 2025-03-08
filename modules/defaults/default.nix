{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum str listOf;

  cfg = config.module.defaults;
in {
  options.module.defaults = {
    # Defaults
    terminal = mkOption {
      type = enum [
        "foot"
        "foot-client"
        "alacritty"
      ];

      default = "foot";
    };

    appLauncher = mkOption {
      type = enum [
        "wofi"
        "rofi"
        "rofi-wayland"
        "fuzzel"
      ];

      default = "rofi-wayland";
    };

    browser = mkOption {
      type = enum [
        "librewolf"
        "firefox"
        "chromium"
      ];

      default = "librewolf";
    };

    # Defaults cmds
    terminalCmd = let
      terminalExecs = {
        foot = "${pkgs.foot}/bin/foot";
        foot-client = "${pkgs.foot}/bin/footclient";
        alacritty = "${pkgs.alacritty}/bin/alacritty";
      };
    in
      mkOption {
        type = str;
        default = terminalExecs.${cfg.terminal};
      };

    browserCmd = let
      browserExecs = {
        librewolf = "${pkgs.librewolf}/bin/librewolf";
        firefox = "${pkgs.firefox}/bin/firefox";
        chromium = "${pkgs.ungoogled-chromium}/bin/chromium";
      };
    in
      mkOption {
        type = str;
        default = browserExecs.${cfg.browser};
      };

    appLauncherCmd = let
      appLauncherExecs = {
        rofi = "${pkgs.rofi}/bin/rofi -show drun";
        rofi-wayland = "${pkgs.rofi-wayland}/bin/rofi -show drun";
        wofi = "${pkgs.wofi}/wofi --show drun";
        fuzzel = "${pkgs.fuzzel}/fuzzel --show drun";
      };
    in
      mkOption {
        type = str;
        default = appLauncherExecs.${cfg.appLauncher};
      };

    audioControlCmd = mkOption {
      type = str;
      default = "${pkgs.pulseaudio}/bin/pactl";
    };

    brightnessControlCmd = mkOption {
      type = str;
      default = "${pkgs.brightnessctl}/bin/brightnessctl";
    };

    clipHistCmd = let
      cliphistBase = "${pkgs.cliphist}/bin/cliphist";
      createExec = launcher: "${cliphistBase} list | ${launcher} | ${cliphistBase} decode | ${pkgs.wl-clipboard}/bin/wl-copy";

      cliphistExecs = {
        rofi = createExec "${pkgs.rofi}/bin/rofi -dmenu";
        rofi-wayland = createExec "${pkgs.rofi-wayland}/bin/rofi -dmenu";
        wofi = createExec "${pkgs.wofi}/bin/wofi --show dmenu";
        fuzzel = createExec "${pkgs.fuzzel}/bin/fuzzel -d";
      };
    in
      mkOption {
        type = str;
        default = cliphistExecs.${cfg.appLauncher};
      };

    notificationsAppCmd = mkOption {
      type = str;
      default = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
    };

    ssh = {
      pubKeys = mkOption {
        type = listOf str;
        default = [];
      };
    };

    network = {
      iface = mkOption {
        type = str;
        default = "";
      };

      ip = mkOption {
        type = str;
        default = "";
      };

      gw = mkOption {
        type = str;
        default = "";
      };

      mask = mkOption {
        type = str;
        default = "";
      };

      cidr = mkOption {
        type = str;
        default = "";
      };
    };
  };
}
