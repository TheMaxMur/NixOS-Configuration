{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.printing;
in {
  options = {
    module.services.printing.enable = mkEnableOption "Enable printing";
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
  };
}
