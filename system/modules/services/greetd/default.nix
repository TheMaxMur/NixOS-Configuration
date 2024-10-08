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
  cfg = config.module.services.greetd;

  cmd = if wm == "hyprland"
    then "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland"
  else if wm == "sway"
    then "${pkgs.sway}/bin/sway"
  else "";
in {
  options = {
    module.services.greetd = {
      enable = mkEnableOption "Enable greetd";
    };
  };

  config = mkIf cfg.enable {
    security.pam.services.greetd = {
      enableGnomeKeyring = true;
    };

    programs.regreet = {
      enable = true;
      cageArgs = [ "-s" "-m" "last" ];
    };

    services.greetd = {
      enable = true;
      vt = 7;

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

