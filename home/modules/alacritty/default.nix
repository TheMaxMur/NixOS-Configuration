{ lib
, config
, ...
}:

with lib;

let
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

        /* font = {
          size = 10;

          normal = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Regular";
          };

          bold = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold";
          };

          italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Italic";
          };

          bold_italic = {
            family = "JetBrainsMono Nerd Font Mono";
            style = "Bold Italic";
          };
        }; */

        window = {
          # opacity = 0.95;

          dimensions = {
            lines = 27;
            columns = 115;
          };

          padding = {
            x = 4;
            y = 4;
          };
        };

        /*colors = {
          draw_bold_text_with_bright_colors = true;

          primary = {
            background = "0x282a33";
            foreground = "0xe1e2e6";
          };

          normal = {
            black = "0x29414f";
            blue = "0x6699cc";
            cyan = "0x5fb3b3";
            green = "0x99c794";
            magenta = "0xc594c5";
            red = "0xec5f67";
            white = "0x65737e";
            yellow = "0xfac863";
          };

          bright = {
            black = "0x405860";
            blue = "0x6699cc";
            cyan = "0x5fb3b3";
            green = "0x99c794";
            magenta = "0xc594c5";
            red = "0xec5f67";
            white = "0xadb5c0";
            yellow = "0xfac863";
          };
        };*/

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

