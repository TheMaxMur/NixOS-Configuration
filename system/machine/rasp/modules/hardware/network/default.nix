{
  config,
  username,
  ...
}: {
  users.users.${username}.openssh.authorizedKeys.keys = config.module.defaults.ssh.pubKeys;

  systemd.network = {
    enable = true;

    networks.eth0 = {
      matchConfig.Name = "eth0";
      address = ["192.168.1.8/24"];
    };
  };

  networking = {
    nftables.enable = true;

    nameservers = [
      "192.168.1.10"
    ];

    firewall = {
      enable = true;

      allowedTCPPorts = [
        22
        53
        80
        443
        3000
        4224
        5335
        8053
        8384
        34561
      ];

      allowedUDPPorts = [
        53
        5335
      ];
    };
  };

  topology.self = {
    interfaces.wt0 = {
      addresses = ["100.92.24.177"];
      renderer.hidePhysicalConnections = false;
      virtual = true;
      type = "wireguard";
      network = "netbird-private";

      physicalConnections = [
        (config.lib.topology.mkConnection "vpntwvm" "wt0")
      ];
    };
  };
}
