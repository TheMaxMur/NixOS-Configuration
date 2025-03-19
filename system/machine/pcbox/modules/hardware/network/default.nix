_: {
  systemd.network = {
    enable = true;

    networks.eth0 = {
      address = ["192.168.1.50/24"];
      dns = ["192.168.1.10"];
    };
  };

  networking = {
    firewall = {
      enable = true;

      allowedTCPPorts = [
        3500
        8384
        22000
      ];

      allowedUDPPorts = [
        22000
        21027
      ];

      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];

      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
    };
  };

  topology.self = {
    interfaces.eth0 = {
      addresses = ["192.168.1.50"];
    };
  };
}
