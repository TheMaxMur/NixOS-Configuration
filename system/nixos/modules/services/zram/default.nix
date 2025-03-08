{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.zram;
in {
  options = {
    module.services.zram.enable = mkEnableOption "Enable zram";
  };

  config = mkIf cfg.enable {
    zramSwap = {
      enable = true;
      priority = 1000;
      algorithm = "zstd";
      swapDevices = 1;
      memoryPercent = 100;
    };
  };
}
