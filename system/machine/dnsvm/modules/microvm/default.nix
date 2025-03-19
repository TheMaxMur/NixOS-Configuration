{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.microvm.nixosModules.microvm
  ];

  microvm = {
    mem = 2 * 1024;
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
        mountPoint = "/";
        image = "root.img";
        size = 45 * 1024;
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
        source = "/run/secrets/dnsvm";
        mountPoint = "/run/secrets/dnsvm";
      }
    ];
  };
}
