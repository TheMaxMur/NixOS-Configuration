{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.neofetch;
in {
  options = {
    module.neofetch.enable = mkEnableOption "Enables neofetch";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.neofetch ];
    xdg.configFile."neofetch/config.conf".source = ./neofetch.conf;
  };
}

