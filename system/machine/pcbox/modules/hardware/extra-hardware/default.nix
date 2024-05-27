{ lib
, pkgs
, config
, ...
}:

{
  # Extra drivers settings
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    firmware = with pkgs; [
      linux-firmware
    ];

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}

