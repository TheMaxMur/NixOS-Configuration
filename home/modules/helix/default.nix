{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.helix;
in {
  options = {
    module.helix.enable = mkEnableOption "Enables helix";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yaml-language-server
      marksman
      gopls
      dockerfile-language-server-nodejs
      cmake-language-server
      nodePackages_latest.bash-language-server
      helm-ls
      nil
    ];

    programs.helix = {
      enable = true;

      settings = {
        theme = "nord";

        editor = {
          line-number = "relative";
          text-width = 70;
          bufferline = "multiple";
          default-line-ending = "lf";
          rulers = [73];
          cursorline = true;
          auto-info = true;
          color-modes = true;

          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };

          soft-wrap = {
            enable = true;
            wrap-at-text-width = true;
          };

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          statusline = {
            left = [
              "mode"
              "spinner"
              "file-modification-indicator"
              "read-only-indicator"
            ];
            center = [
              "version-control"
              "file-name"
            ];
            right = [
              "diagnostics"
              "selections"
              "position"
              "file-encoding"
              "file-line-ending"
              "file-type"
            ];
            separator = "│";
            mode = {
              normal = "NORMAL";
              insert = "-- INSERT --";
              select = "-- SELECT --";
            };
          };

          indent-guides = {
            render = true;
            character = "▏";
          };
        };

        keys = {
          insert = {
            j.k = "normal_mode";
          };
        };
      };
    };
  };
}
