{
  config,
  lib,
  hostname,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.sway.outputs;

  outputs = {
    default = {};

    pcbox = {
      DP-1 = {
        resolution = "1920x1080@144Hz";
        position = "0 0";
      };

      DP-2 = {
        resolution = "1920x1080@144Hz";
        position = "1920 0";
      };
    };

    nbox = {
      eDP-1 = {
        resolution = "2880x1800@120Hz";
        position = "0 0";
      };
    };

    p8box = {
      DSI-1 = {
        resolution = "800x1280@60Hz";
        position = "0 0";
      };
    };
  };

  workspaces = {
    default = [];

    pcbox = [
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

    nbox = [
      {
        workspace = "1";
        output = "eDP-1";
      }
      {
        workspace = "2";
        output = "eDP-1";
      }
      {
        workspace = "3";
        output = "eDP-1";
      }
      {
        workspace = "4";
        output = "eDP-1";
      }
      {
        workspace = "5";
        output = "eDP-1";
      }
      {
        workspace = "6";
        output = "eDP-1";
      }
    ];

    p8box = [
      {
        workspace = "1";
        output = "eDP-1";
      }
      {
        workspace = "2";
        output = "eDP-1";
      }
      {
        workspace = "3";
        output = "eDP-1";
      }
      {
        workspace = "4";
        output = "eDP-1";
      }
      {
        workspace = "5";
        output = "eDP-1";
      }
      {
        workspace = "6";
        output = "eDP-1";
      }
    ];
  };
in {
  options.module.sway.outputs = {
    enable = mkEnableOption "Enable sway outputs";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway.config = {
      output = outputs.${hostname};

      workspaceOutputAssign = workspaces.${hostname};
    };
  };
}
