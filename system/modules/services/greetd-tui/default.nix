{ pkgs
, lib
, config
, username
, inputs
, wm
, ...
}:

with lib;

let
  cfg = config.module.services.greetd-tui;

  cmd = if wm == "hyprland"
    then "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland"
  else if wm == "sway"
    then "${pkgs.swayfx}/bin/sway"
  else "";
in {
  options = {
    module.services.greetd-tui = {
      enable = mkEnableOption "Enable greetd-tui";
    };
  };

  config = mkIf cfg.enable {
    security.pam.services.greetd = {
      enableGnomeKeyring = true;
    };

    services.greetd = {
      enable = true;
      vt = 2;

      settings = {
        default_session = {
          user = username;

          command = builtins.concatStringsSep " " [
            "${pkgs.greetd.tuigreet}/bin/tuigreet"
            "--asterisks"
            "--remember"
            "--time"
            "--cmd ${cmd}"
          ];
        };
      };
    };
  };
}

