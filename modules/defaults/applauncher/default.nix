{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum str;

  cfg = config.module.defaults;
in {
  options.module.defaults = {
    appLauncher = mkOption {
      type = enum [
        "wofi"
        "rofi"
        "rofi-wayland"
        "fuzzel"
      ];

      default = "rofi-wayland";
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
  };
}
