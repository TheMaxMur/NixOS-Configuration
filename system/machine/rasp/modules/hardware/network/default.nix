{ config
, ...
}:

{
  systemd.network = {
    enable = true;

    networks.eth0 = {
      matchConfig.Name = "eth0";
      address = [ "192.168.1.8/24" ];
    };
  };

  networking = {
    nameservers = [
      "192.168.1.8"
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
      ];

      allowedUDPPorts = [
        53
        5335
      ];
    };
  };

  topology.self = {
    services = {
      nginx.details = {
        "https" = { text = "0.0.0.0:443"; };
        "gitlab ssh" = { text = "0.0.0.0:4224"; };
        "syncthing web" = { text = "0.0.0.0:8384"; };
      };

      adguardhome.details = {
        "dns" = { text = "192.168.1.8:53"; };
      };
    };

    interfaces.wg0 = {
      addresses = [ "10.200.100.3" ];
      renderer.hidePhysicalConnections = false;
      virtual = true;
      type = "wireguard";
      physicalConnections = [
        (config.lib.topology.mkConnection "site" "wg0")
      ];
    };
  };
}

