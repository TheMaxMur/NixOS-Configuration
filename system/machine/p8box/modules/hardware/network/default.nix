_: {
  systemd.network = {
    enable = true;
  };

  networking = {
    firewall = {
      enable = true;

      allowedTCPPorts = [
        8384
        22000
      ];

      allowedUDPPorts = [
        22000
        21027
      ];

      allowedTCPPortRanges = [
      ];

      allowedUDPPortRanges = [
      ];
    };
  };

  topology.self = {
    interfaces.wlp3s0 = {
      addresses = ["192.168.1.102"];
    };
  };
}
