{pkgs, ...}: {
  # Kernel settings
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;

    extraModulePackages = [];

    kernelModules = [
      "kvm-intel"
    ];

    initrd.kernelModules = [
      "i915"
    ];

    kernelParams = [
      # Video driver settings
      "i915.enable_guc=1"
      "pci=assign-busses,hpbussize=0x33,realloc"
    ];

    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "vmd"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];
  };
}
