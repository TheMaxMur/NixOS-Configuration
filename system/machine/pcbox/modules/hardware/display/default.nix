{username, ...}: let
  settings = {
    sway = {
      output = {
        DP-1 = {
          resolution = "1920x1080@144Hz";
          position = "0 0";
        };

        DP-2 = {
          resolution = "1920x1080@144Hz";
          position = "1920 0";
        };
      };

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DP-2";
        }
        {
          workspace = "2";
          output = "DP-2";
        }
        {
          workspace = "3";
          output = "DP-2";
        }
        {
          workspace = "4";
          output = "DP-2";
        }
        {
          workspace = "5";
          output = "DP-2";
        }
        {
          workspace = "6";
          output = "DP-2";
        }
        {
          workspace = "7";
          output = "DP-1";
        }
        {
          workspace = "8";
          output = "DP-1";
        }
        {
          workspace = "9";
          output = "DP-1";
        }
        {
          workspace = "10";
          output = "DP-1";
        }
        {
          workspace = "11";
          output = "DP-1";
        }
        {
          workspace = "12";
          output = "DP-1";
        }
      ];
    };

    hyprland = {
      monitor = [
        "DP-1,1920x1080@144,0x0,1"
        "DP-2,1920x1080@144,1920x0,1"
      ];

      workspace = [
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
      ];
    };
  };
in {
  home-manager.users.${username}.wayland.windowManager = {
    sway.config = settings.sway;
    hyprland.settings = settings.hyprland;
  };
}
