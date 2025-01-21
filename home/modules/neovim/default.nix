{
  self,
  lib,
  config,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.module.nvim;
in
{
  options = {
    module.nvim.enable = mkEnableOption "Enables nvim";
  };

  config = mkIf cfg.enable {
    xdg.configFile."nvim" = {
      source = "${self}/home/modules/neovim/config";
      recursive = true;
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      extraPackages = with pkgs; [
        gcc
        nodejs_22
        ansible-language-server
        yaml-language-server
        marksman
        gopls
        dockerfile-language-server-nodejs
        docker-compose-language-service
        cmake-language-server
        helm-ls
        nil
        nixd
        lua-language-server
        stylua
        pyright
      ];
    };
  };
}
