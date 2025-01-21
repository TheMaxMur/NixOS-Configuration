{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.bluetooth;
in
{
  options = {
    module.bluetooth = {
      enable = mkEnableOption "Enables bluetooth";
    };
  };

  config = mkIf cfg.enable {
    services.blueman.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
