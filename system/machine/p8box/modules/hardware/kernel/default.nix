{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    kernelModules = [
      "kvm-intel"
    ];

    kernelParams = [
      "fbcon=rotate:1"
      "video=DSI-1:panel_orientation=right_side_up"
    ];

    extraModulePackages = [];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"

        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
        "uas"
      ];
    };
  };
}
