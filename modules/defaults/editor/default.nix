{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum str;

  cfg = config.module.defaults;
in {
  options.module.defaults = {
    editor = mkOption {
      type = enum [
        "helix"
        "neovim"
      ];

      default = "neovim";
    };

    editorCmd = let
      editorExecs = {
        helix = "${pkgs.helix}/bin/helix";
        neovim = "${pkgs.neovim-unwrapped}/bin/neovim";
      };
    in
      mkOption {
        type = str;
        default = editorExecs.${cfg.editor};
      };
  };
}
