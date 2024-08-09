{ inputs
, config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.doom-emacs;
in {
  options = {
    module.doom-emacs.enable = mkEnableOption "Enable doom-emacs";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      emacs
      emacsPackages.vterm
      emacsPackages.python
      emacsPackages.emacsql
      emacsPackages.emacsql-sqlite
      emacsPackages.pdf-tools

      fd
      nerdfonts
      nil
     ];
  };
}

