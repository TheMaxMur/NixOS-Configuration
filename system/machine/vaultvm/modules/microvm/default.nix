{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.microvm.nixosModules.microvm
  ];

  microvm = {
    mem = 4 * 1024;
    vcpu = 2;
    storeDiskType = "squashfs";

    hypervisor = "cloud-hypervisor";

    interfaces = [
      {
        id = config.module.defaults.network.iface;
        type = "tap";
        inherit (config.module.defaults.network) mac;
      }
    ];

    volumes = [
      {
        mountPoint = "/var/lib";
        image = "db.img";
        size = 30 * 1024;
      }
    ];

    shares = [
      {
        proto = "virtiofs";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
      {
        proto = "virtiofs";
        tag = "secrets";
        source = "/run/secrets/vaultwarden";
        mountPoint = "/run/secrets/vaultwarden";
      }
    ];
  };
}
