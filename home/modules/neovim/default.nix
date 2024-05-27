{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.nvim;
in {
  options = {
    module.nvim.enable = mkEnableOption "Enables nvim";
  };

  config = mkIf cfg.enable {
    xdg.configFile."nvim" = {
      source = ./config;
      recursive = true;
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      extraPackages = with pkgs; [
        yaml-language-server
        marksman
        gopls
        dockerfile-language-server-nodejs
        cmake-language-server
        nodePackages_latest.bash-language-server
        helm-ls
        nil
      ];
    };
  };
}

