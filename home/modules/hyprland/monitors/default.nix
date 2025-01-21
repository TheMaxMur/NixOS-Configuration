{
  config,
  lib,
  hostname,
  ...
}:

with lib;

let
  cfg = config.module.hyprland.monitors;

  monitorsSettings =
    if hostname == "pcbox" then
      [
        "DP-1,1920x1080@144,0x0,1"
        "DP-2,1920x1080@144,1920x0,1"
      ]
    else if hostname == "nbox" then
      [ "eDP-1,2880x1800@120,0x0,1.8" ]
    else
      [ ];

  workspacesSettings =
    if hostname == "pcbox" then
      [
        "1, monitor:DP-2, default:true"
        "2, monitor:DP-2, default:true"
        "3, monitor:DP-2, default:true"
        "4, monitor:DP-2, default:true"
        "5, monitor:DP-2, default:true"
        "6, monitor:DP-2, default:true"
        "7, monitor:DP-1, default:true"
        "8, monitor:DP-1, default:true"
        "9, monitor:DP-1, default:true"
        "10, monitor:DP-1, default:true"
        "11, monitor:DP-1, default:true"
        "12, monitor:DP-1, default:true"
      ]
    else if hostname == "nbox" then
      [
        "1, monitor:eDP-1, default:true"
        "2, monitor:eDP-1, default:true"
        "3, monitor:eDP-1, default:true"
        "4, monitor:eDP-1, default:true"
        "5, monitor:eDP-1, default:true"
        "6, monitor:eDP-1, default:true"
        # "7, monitor:eDP-1, default:true"
        # "8, monitor:eDP-1, default:true"
        # "9, monitor:eDP-1, default:true"
        # "10, monitor:eDP-1, default:true"
        # "11, monitor:eDP-1, default:true"
        # "12, monitor:eDP-1, default:true"
      ]
    else
      [ ];
in
{
  options = {
    module.hyprland.monitors.enable = mkEnableOption "Enables monitors in Hyprland";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      monitor = monitorsSettings;
      workspace = workspacesSettings;
    };
  };
}
