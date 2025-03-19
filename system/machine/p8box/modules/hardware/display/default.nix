{username, ...}: let
  settings = {
    sway = {
      output = {
        DSI-1 = {
          resolution = "800x1280@60Hz";
          position = "0 0";
        };
      };

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DSI-1";
        }
        {
          workspace = "2";
          output = "DSI-1";
        }
        {
          workspace = "3";
          output = "DSI-1";
        }
        {
          workspace = "4";
          output = "DSI-1";
        }
        {
          workspace = "5";
          output = "DSI-1";
        }
        {
          workspace = "6";
          output = "DSI-1";
        }
      ];
    };

    hyprland = {
      monitor = ["DSI-1,800x1280@60,0x0,1.8"];

      workspace = [
        "1, monitor:DSI-1, default:true"
        "2, monitor:DSI-1, default:true"
        "3, monitor:DSI-1, default:true"
        "4, monitor:DSI-1, default:true"
        "5, monitor:DSI-1, default:true"
        "6, monitor:DSI-1, default:true"
      ];
    };
  };
in {
  home-manager.users.${username}.wayland.windowManager = {
    sway.config = settings.sway;
    hyprland.settings = settings.hyprland;
  };
}
