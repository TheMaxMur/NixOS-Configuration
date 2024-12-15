{ config
, username
, ...
}:

{
  users.users.${username}.openssh.authorizedKeys.keys = config.module.defaults.ssh.pubKeys;

  networking = {
    hostId = "1ac5a44c";
  };

  systemd.network = {
    netdevs."vmbr0" = {
      netdevConfig = {
        Name = "vmbr0";
        Kind = "bridge";
      };
    };

    networks = {
      "10-lan" = {
        matchConfig.Name = [ config.module.defaults.network.iface ];
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
          { Gateway = config.module.defaults.network.gw; }
        ];
      };
    };
  };
}

