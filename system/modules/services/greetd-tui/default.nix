{ pkgs
, lib
, config
, username
, inputs
, ...
}:

with lib;

let
  cfg = config.module.services.greetd-tui;
in {
  options = {
    module.services.greetd-tui.enable = mkEnableOption "Enable greetd-tui";
  };

  config = mkIf cfg.enable {
    security.pam.services.greetd = {
      enableGnomeKeyring = true;
    };

    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          user = username;

          command = builtins.concatStringsSep " " [
            "${pkgs.greetd.tuigreet}/bin/tuigreet"
            "--asterisks"
            "--remember"
            "--time"
            "--cmd ${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland"
            # "--cmd ${pkgs.hyprland}/bin/Hyprland"
          ];
        };
      };
    };
  };
}

