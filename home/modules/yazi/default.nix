{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.yazi;
in
{
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
