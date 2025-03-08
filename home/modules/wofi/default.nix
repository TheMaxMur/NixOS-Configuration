{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.wofi;
in {
  options = {
    module.wofi = {
      enable = mkEnableOption "Enable wofi app runner";
    };
  };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;

      settings = {
        allow_images = true;
        insensitive = true;
        width = "30%";
      };
    };
  };
}
