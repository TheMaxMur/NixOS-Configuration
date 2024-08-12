{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.hyprpaper;
in {
  options = {
    module.hyprpaper.enable = mkEnableOption "Enables hyprpaper";
  };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;

      settings = {
        preload = [ "../../../assets/grey_gradient.png" ];
        wallpapers = [ "../../../assets/grey_gradient.png" ];
      };
    };
  };
}

