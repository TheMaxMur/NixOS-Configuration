{
  lib,
  pkgs,
  config,
  ...
}:

{
  # Extra drivers settings
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    firmware = with pkgs; [
      sof-firmware
      linux-firmware
    ];

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
