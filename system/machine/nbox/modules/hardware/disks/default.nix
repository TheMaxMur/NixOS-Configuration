{ inputs
, ...
}:

{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  fileSystems = {
    "/" = {
      fsType = "tmpfs";
      options = [ "mode=755" "size=10G" ];
    };

    "/nix" = {
      options = [ "compress=zstd" "subvol=nix" ];
    };

    "/persist" = {
      neededForBoot = true;
      options = [ "compress=zstd" "subvol=persist" ];
    };
  };

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_PC_SN560_SDDPNQE-1T00-1102_23326L401726";

        content = {
          type = "gpt";

          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";

                mountOptions = [ "defaults" "umask=0077" ];
              };
            };

            luks = {
              size = "100%";

              content = {
                type = "luks";
                name = "crypted";

                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];

                  subvolumes = {
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };

                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "compress=zstd" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };

    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [ "mode=755" "size=10G" ];
      };
    };
  };
}

