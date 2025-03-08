{config, ...}: let
  ipKernelParam = with config.module.defaults.network; [
    "ip=${ip}::${gw}:${mask}::${iface}:none"
  ];
in {
  boot = {
    kernelModules = [
      "kvm-intel"
      "r8169"
    ];
    extraModulePackages = [];
    kernelParams =
      [
        "zfs.zfs_arc_max=2147483648"
      ]
      ++ ipKernelParam;

    initrd = {
      availableKernelModules = [
        "ath10k_pci"
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "r8169"
      ];
      kernelModules = [];

      network = {
        enable = true;

        ssh = {
          enable = true;
          port = 2222;
          hostKeys = [/etc/secrets/initrd/ssh_host_ed25519_key];
          authorizedKeys = config.module.defaults.ssh.pubKeys;
        };
      };
    };
  };
}
