{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.bolt;
in {
  options = {
    module.services.bolt.enable = mkEnableOption "Enable bolt";
  };

  config = mkIf cfg.enable {
    services.hardware.bolt.enable = true;
  };
}
