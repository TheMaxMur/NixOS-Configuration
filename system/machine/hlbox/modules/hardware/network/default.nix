{
  config,
  username,
  lib,
  self,
  ...
}: let
  inherit (lib) genList;

  maxVMs = 5;

  vmNetworks = builtins.listToAttrs (
    map (index: {
      name = "30-vm${toString index}";
      value = {
        matchConfig.Name = "vm${toString index}";

        address = [
          "10.0.0.0/32"
        ];

        routes = [
          {
            Destination = "10.0.0.${toString index}/32";
          }
        ];

        networkConfig = {
          IPv4Forwarding = true;
        };
      };
    }) (genList (i: i + 1) maxVMs)
  );
in {
  users.users.${username}.openssh.authorizedKeys.keys = config.module.defaults.ssh.pubKeys;

  networking = {
    hostId = "1ac5a44c";
    nftables.enable = true;

    nat = {
      enable = true;
      internalIPs = ["10.0.0.0/24"];
      externalInterface = "vmbr0";

      forwardPorts = [
        {
          destination = "10.0.0.2:53";
          proto = "udp";
          sourcePort = 53;
        }
        {
          destination = "10.0.0.2:53";
          proto = "tcp";
          sourcePort = 53;
        }
      ];
    };

    firewall = {
      enable = true;

      allowedTCPPorts = [
        53
        80
        443
        4224
      ];

      allowedUDPPorts = [
        53
      ];
    };
  };

  systemd.network = {
    netdevs."vmbr0" = {
      netdevConfig = {
        Name = "vmbr0";
        Kind = "bridge";
      };
    };

    networks =
      {
        "10-lan" = {
          matchConfig.Name = [config.module.defaults.network.iface "vm-*"];
          networkConfig = {
            Bridge = "vmbr0";
          };
        };

        "10-lan-bridge" = {
          matchConfig.Name = "vmbr0";
          linkConfig.RequiredForOnline = "routable";

          address = [
            "${config.module.defaults.network.ip}/${config.module.defaults.network.cidr}"
          ];

          routes = [
            {Gateway = config.module.defaults.network.gw;}
          ];

          networkConfig = {
            DNS = [
              "10.0.0.2"
            ];
          };
        };
      }
      // vmNetworks;
  };

  topology.self = let
    interfaces = builtins.listToAttrs (builtins.map (index: {
      name = "vm${builtins.toString index}";
      value = {
        addresses = ["10.0.0.0"];
        network = "hlbox-nat";
      };
    }) (lib.genList (i: i + 1) maxVMs));
  in {
    inherit interfaces;

    services = {
      psql = {
        name = "Proxmox";
        icon = "${self}/parts/topology/images/services/proxmox.jpg";
      };
    };
  };
}
