{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.irqbalance;
in {
  options = {
    module.services.irqbalance.enable = mkEnableOption "Enables irqbalance";
  };

  config = mkIf cfg.enable {
    services.irqbalance = {
      enable = true;
    };
  };
}
