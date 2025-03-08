{pkgs, ...}: {
  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;

    firmware = with pkgs; [
      linux-firmware
    ];
  };
}
