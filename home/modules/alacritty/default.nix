{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.alacritty;
in {
  options = {
    module.alacritty.enable = mkEnableOption "Enables Alacritty";
  };

  config = mkIf cfg.enable {
    # Terminal emulator alacritty
    programs.alacritty = {
      enable = true;

      settings = {
        env.TERM = "xterm-256color";

        cursor.style = {
          shape = "Beam";
          blinking = "off";
        };

        window = {
          dimensions = {
            lines = 27;
            columns = 115;
          };

          padding = {
            x = 4;
            y = 4;
          };
        };

        keyboard.bindings = [
          {
            action = "Copy";
            key = "C";
            mods = "Control";
          }
          {
            action = "Copy";
            key = "С";
            mods = "Control";
          }
          {
            action = "Paste";
            key = "V";
            mods = "Control";
          }
          {
            action = "Paste";
            key = "М";
            mods = "Control";
          }
          {
            action = "Paste";
            key = "Insert";
            mods = "Shift";
          }
          {
            action = "PasteSelection";
            key = "Insert";
            mods = "Shift";
          }
          {
            action = "PasteSelection";
            key = "Insert";
          }
          {
            chars = "\\u0003";
            key = "C";
            mods = "Control|Shift";
          }
          {
            chars = "\\u0003";
            key = "С";
            mods = "Control|Shift";
          }
        ];
      };
    };
  };
}
