{
  config,
  username,
  self,
  ...
}: {
  users.users.${username}.openssh.authorizedKeys.keys = config.module.defaults.ssh.pubKeys;

  networking = {
    hostName = "vpntwvm";

    firewall = {
      allowedTCPPorts = [
        22
        80
        443
        10000
        33080
        33073
        54315
      ];

      allowedUDPPorts = [
        3478
      ];

      allowedUDPPortRanges = [
        {
          from = 49152;
          to = 65535;
        }
      ];
    };
  };

  systemd.network = {
    enable = true;

    networks = {
      "10-wan" = {
        matchConfig.Name = config.module.defaults.network.iface;

        address = [
          "${config.module.defaults.network.ip}/${config.module.defaults.network.cidr}"
        ];

        routes = [
          {Gateway = config.module.defaults.network.gw;}
        ];

        networkConfig = {
          DNS = [
            "8.8.8.8"
            "8.8.4.4"
          ];
        };
      };
    };
  };

  topology.self = {
    services = {
      netbird = {
        name = "NetBird";
        icon = "${self}/parts/topology/images/services/netbird.png";
      };

      keycloak = {
        name = "Keycloak";
        icon = "${self}/parts/topology/images/services/keycloak.png";
      };

      psql = {
        name = "Postgresql";
        icon = "${self}/parts/topology/images/services/psql.png";
      };
    };

    interfaces = {
      wt0 = {
        addresses = ["100.92.0.1"];
        renderer.hidePhysicalConnections = false;
        virtual = true;
        type = "wireguard";
        network = "netbird-private";
      };
    };
  };
}
