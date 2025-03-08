{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.foot;

  serverEnable =
    if config.module.defaults.terminal == "foot-client"
    then true
    else false;
in {
  options = {
    module.foot.enable = mkEnableOption "Enables Foot";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = serverEnable;

      settings = {
        main = {
          term = "xterm-256color";
          workers = 32;
          initial-window-size-chars = "115x24";
          pad = "4x4 center";
        };

        cursor = {
          style = "beam";
          beam-thickness = 1;
        };

        mouse = {
          hide-when-typing = "no";
        };

        key-bindings = {
          clipboard-copy = "Control+c XF86Copy";
          clipboard-paste = "Control+v XF86Paste";
          noop = "Mod4+space";
        };

        text-bindings = {
          "\\x03" = "Control+Shift+c Control+Shift+C";
        };
      };
    };
  };
}
