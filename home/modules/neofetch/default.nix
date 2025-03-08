{
  self,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.neofetch;
in {
  options = {
    module.neofetch.enable = mkEnableOption "Enables neofetch";
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.neofetch];
    xdg.configFile."neofetch/config.conf".source = "${self}/home/modules/neofetch/neofetch.conf";
  };
}
