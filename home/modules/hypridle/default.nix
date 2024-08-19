{ config
, lib
, pkgs
, inputs
, hostname
, ...
}:

with lib;

let
  cfg = config.module.hypridle;

  hyprlockCmd = "${config.programs.hyprlock.package}/bin/hyprlock";
  suspendCmd = "${pkgs.systemd}/bin/systemctl suspend";
  hyprctlCmd = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/hyprctl";

  hyprlandOnScreen = "${hyprctlCmd} dispatch dpms on";
  hyprlandOffScreen = "${hyprctlCmd} dispatch dpms off";
  swayOnScreen = "${pkgs.swayfx}/bin/swaymsg 'output * power on'";
  swayOffScreen = "${pkgs.swayfx}/bin/swaymsg 'output * power off'";
  screenOn = if config.module.hyprland.enable 
    then hyprlandOnScreen 
    else if config.module.sway.enable 
      then swayOnScreen 
    else "";
  screenOff = if config.module.hyprland.enable 
    then hyprlandOffScreen 
    else if config.module.sway.enable 
      then swayOffScreen 
    else "";
in {
  options = {
    module.hypridle.enable = mkEnableOption "Enables Hypridle";
  };

  config = mkIf cfg.enable {
    # https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "${hyprlockCmd}";
          unlock_cmd = "";
          before_sleep_cmd = "${hyprlockCmd}";
          after_sleep_cmd = "";
          ignore_dbus_inhibit = false;
        };

        listener = [
          {
            timeout = 300;
            on-timeout = screenOff;
            on-resume = screenOn;
          }
          {
            timeout = 600;
            on-timeout = hyprlockCmd;
            on-resume = "";
          }
        ] ++ lib.optionals (hostname == "nbox") [
          {
            timeout = 900;
            on-timeout = suspendCmd;
            on-resume = "";
          }
        ];
      };
    };
  };
}

