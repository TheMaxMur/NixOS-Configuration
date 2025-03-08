{
  lib,
  config,
  ...
}: let
  inherit (lib) mkDefault;
in {
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
  };
}
