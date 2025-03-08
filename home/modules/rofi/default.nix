{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.rofi;
in {
  options = {
    module.rofi.enable = mkEnableOption "Enables rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      cycle = false;
      package = pkgs.rofi-wayland;
      location = "center";
      terminal = "foot";

      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
      ];

      extraConfig = {
        modi = "drun,window";
        display-drun = "APPS";
        display-window = "WINDOW";
        drun-display-format = "{name}";
      };

      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          width = 500;
        };

        "window" = {
          height = mkLiteral "550px";
          border = mkLiteral "3px";
        };

        "inputbar" = {
          children = map mkLiteral [
            "prompt"
            "entry"
          ];
          border-radius = mkLiteral "5px";
          padding = mkLiteral "2px";
        };

        "prompt" = {
          padding = mkLiteral "6px";
          border-radius = mkLiteral "3px";
          margin = mkLiteral "20px 0px 0px 20px";
        };

        "textbox-prompt-colon" = {
          expand = "false";
          str = ":";
        };

        "entry" = {
          padding = mkLiteral "6px";
          border-radius = mkLiteral "3px";
          margin = mkLiteral "20px 10px 0px 10px";
        };

        "listview" = {
          border = mkLiteral "0px 0px 0px";
          padding = mkLiteral "6px 0px 0px";
          margin = mkLiteral "10px 15px 0px 20px";
          columns = "2";
          lines = "8";
        };

        "element" = {
          padding = mkLiteral "5px";
        };

        "element-icon" = {
          size = mkLiteral "25px";
        };

        "element selected" = {
          border-radius = mkLiteral "3px";
        };

        "button" = {
          padding = mkLiteral "10px";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };

        "textbox" = {
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
          blink = true;
          markup = true;
        };

        "error-message" = {
          padding = mkLiteral "10px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px";
        };
      };
    };
  };
}
