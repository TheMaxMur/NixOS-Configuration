{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.plymouth;
in {
  options = {
    module.plymouth = {
      enable = mkEnableOption "Enables plymouth";
    };
  };

  config = mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
    };
  };
}
