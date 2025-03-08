{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.swaylock;
in {
  options = {
    module.swaylock = {
      enable = mkEnableOption "Enable swaylock";
    };
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
    };
  };
}
