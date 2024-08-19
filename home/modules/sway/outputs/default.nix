{ config
, lib
, hostname
, ...
}:

with lib;

let
  cfg = config.module.sway.outputs;

  pcboxOutputs = {
    DP-1 = { 
      resolution = "1920x1080@144Hz";
      position = "0 0";
    };
    
    DP-2 = {
      resolution = "1920x1080@144Hz";
      position = "1920 0";
    };
  };

  nboxOutputs = {
    eDP-1 = {
      resolution = "2880x1800@120Hz";
      position = "0 0";
    };
  };

  outputsByHostname = if hostname == "pcbox"
    then pcboxOutputs
  else if hostname == "nbox"
    then nboxOutputs
  else {};

  pcboxWorkspaces = [
    { workspace = "1"; output = "DP-2"; }
    { workspace = "2"; output = "DP-2"; }
    { workspace = "3"; output = "DP-2"; }
    { workspace = "4"; output = "DP-2"; }
    { workspace = "5"; output = "DP-2"; }
    { workspace = "6"; output = "DP-2"; }
    { workspace = "7"; output = "DP-1"; }
    { workspace = "8"; output = "DP-1"; }
    { workspace = "9"; output = "DP-1"; }
    { workspace = "10"; output = "DP-1"; }
    { workspace = "11"; output = "DP-1"; }
    { workspace = "12"; output = "DP-1"; }
  ];

  nboxWorkspaces = [
    { workspace = "1"; output = "eDP-1"; }
    { workspace = "2"; output = "eDP-1"; }
    { workspace = "3"; output = "eDP-1"; }
    { workspace = "4"; output = "eDP-1"; }
    { workspace = "5"; output = "eDP-1"; }
    { workspace = "6"; output = "eDP-1"; }
  ];

  workspacesByHostname = if hostname == "pcbox"
    then pcboxWorkspaces
  else if hostname == "nbox"
    then nboxWorkspaces
  else [];
in {
  options.module.sway.outputs = {
    enable = mkEnableOption "Enable sway outputs";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway.config = {
      output = outputsByHostname;

      workspaceOutputAssign = workspacesByHostname;
    };
  };
}

