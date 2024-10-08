_:

{
  systemd.network = {
    enable = true;

    networks.eth0 = {
      matchConfig.Name = "enp0s31f6";
      address = [ "192.168.1.50/24" ];
      dns = [ "192.168.1.8" ];
    };
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
        { from = 1714; to = 1764; } # KDE Connect
      ];
      
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
    };
  };
}

