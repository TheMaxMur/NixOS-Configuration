{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str;

  cfg = config.module.defaults;
in {
  options.module.defaults = {
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
  };
}
