{config, ...}: {
  module = {
    locales.enable = true;
    security.enable = true;
    timedate.enable = true;
    stylix.enable = true;
    users.enable = true;
    minimal.enable = true;

    programs = {
      hm.enable = true;
      zsh.enable = true;
      fish.enable = true;
      systemPackages.enable = true;
    };

    defaults = {
      network = {
        iface = "vm3";
        ip = "10.0.0.3";
        gw = "10.0.0.0";
        mask = "255.255.255.0";
        cidr = "24";
        mac = "02:00:00:00:00:00";
      };

      ssh.pubKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWJULtMSQfTZqoXwfK32T+V+NZMqM+1rKhURlee8yS+ maxmur"
      ];
    };

    services = {
      fail2ban.enable = true;

      postgresql = {
        enable = true;
        dataDir = "/var/lib/postgresql/17";
        authentication = "host all all 0.0.0.0/0 scram-sha-256";
        enableTCPIP = true;

        configurations = [
          "forgejo"
          "vaultwarden"
          "paperless"
          "woodpecker"
          "grafana"
        ];
      };

      ssh = {
        enable = true;
        listenAddresses = [
          {
            addr = config.module.defaults.network.ip;
            port = 34861;
          }
        ];
      };
    };
  };
}
