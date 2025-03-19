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
    # Defaults
    terminal = mkOption {
      type = enum [
        "foot"
        "footclient"
        "alacritty"
      ];

      default = "foot";
    };

    # Defaults cmds
    terminalCmd = let
      terminalExecs = {
        foot = "${pkgs.foot}/bin/foot";
        footclient = "${pkgs.foot}/bin/footclient";
        alacritty = "${pkgs.alacritty}/bin/alacritty";
      };
    in
      mkOption {
        type = str;
        default = terminalExecs.${cfg.terminal};
      };
  };
}
