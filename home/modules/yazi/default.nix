{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.yazi;
in {
  options = {
    module.yazi.enable = mkEnableOption "Enables yazi";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
