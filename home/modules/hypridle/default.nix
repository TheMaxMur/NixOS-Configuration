{ config
, lib
, pkgs
, inputs
, hostname
, swayEnable
, hyprlandEnable
, ...
}:

with lib;

let
  cfg = config.module.hypridle;

  suspendCmd = "${pkgs.systemd}/bin/systemctl suspend";
  hyprctlCmd = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/hyprctl";
  swaymsg    = "${pkgs.swayfx}/bin/swaymsg";

  hyprlockCmd = "${config.programs.hyprlock.package}/bin/hyprlock";
  swaylockCmd = "${pkgs.swaylock}/bin/swaylock";
  lockScreen  = if hyprlandEnable
    then hyprlockCmd
  else if swayEnable
    then swaylockCmd
  else "";

  hyprlandOnScreen = "${hyprctlCmd} dispatch dpms on";
  hyprlandOffScreen = "${hyprctlCmd} dispatch dpms off";
  swayOnScreen = "${swaymsg} 'output * power on'";
  swayOffScreen = "${swaymsg} 'output * power off'";
  screenOn = if hyprlandEnable 
    then hyprlandOnScreen 
  else if swayEnable
    then swayOnScreen 
  else "";
  screenOff = if hyprlandEnable
    then hyprlandOffScreen 
  else if swayEnable
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
          lock_cmd = "${lockScreen}";
          unlock_cmd = "";
          before_sleep_cmd = "${lockScreen}";
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
            on-timeout = lockScreen;
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

