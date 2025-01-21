{
  pkgs,
  config,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;

    kernelModules = [
      "amdgpu"
      "kvm-amd"
      "kvm-intel"
      "zenpower"
    ];

    extraModulePackages = [
      config.boot.kernelPackages.zenpower
    ];

    kernelParams = [
      "drm_kms_helper.poll=0"
    ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      kernelModules = [
        "amdgpu"
      ];
    };
  };
}
