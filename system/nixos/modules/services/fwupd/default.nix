{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.fwupd;
in {
  options = {
    module.services.fwupd.enable = mkEnableOption "Enable fwupd";
  };

  config = mkIf cfg.enable {
    services.fwupd.enable = true;
  };
}
