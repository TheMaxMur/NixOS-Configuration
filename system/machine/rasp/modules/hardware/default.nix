{
  self,
  machineDir,
  pkgs,
  allDirs,
  ...
}: let
  machineHardwareModulesPath = "${self}/system/machine/${machineDir}/modules/hardware";
in {
  imports = allDirs machineHardwareModulesPath;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];

    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  hardware.enableRedistributableFirmware = true;
  nix.settings.trusted-users = [
    "maxmur"
    "root"
  ];
}
