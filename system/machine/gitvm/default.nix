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
        iface = "vm4";
        ip = "10.0.0.4";
        gw = "10.0.0.0";
        mask = "255.255.255.0";
        cidr = "24";
        mac = "02:00:00:02:00:00";
      };

      ssh.pubKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWJULtMSQfTZqoXwfK32T+V+NZMqM+1rKhURlee8yS+ maxmur"
      ];
    };

    services = {
      fail2ban.enable = true;

      forgejo = {
        enable = true;
        domain = "git.maxmur.info";
        httpAddr = "0.0.0.0";
        sshPort = 4224;

        database = {
          createDatabase = true;
          name = "forgejo";
          type = "postgres";
          user = "forgejo";
          host = "10.0.0.3";
          passwordFile = "/run/secrets/db/forgejo/user";
        };
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
