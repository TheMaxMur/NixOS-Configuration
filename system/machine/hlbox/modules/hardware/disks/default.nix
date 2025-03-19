_: {
  swapDevices = [];

  boot.zfs = {
    extraPools = [
      "zmirror"
      "zpool1"
      "zpool2"
    ];
  };

  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "zpool/root";
      fsType = "zfs";
      options = ["zfsutil"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/2D7C-60DB";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/home" = {
      device = "zpool/home";
      fsType = "zfs";
      options = ["zfsutil"];
    };

    "/nix" = {
      device = "zpool/nix";
      fsType = "zfs";
      options = ["zfsutil"];
    };
  };
}
