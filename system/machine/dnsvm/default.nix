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
        iface = "vm2";
        ip = "10.0.0.2";
        gw = "10.0.0.0";
        mask = "255.255.255.0";
        cidr = "24";
        mac = "02:02:00:00:00:02";
      };

      ssh.pubKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWJULtMSQfTZqoXwfK32T+V+NZMqM+1rKhURlee8yS+ maxmur"
      ];
    };

    services = {
      fail2ban.enable = true;

      adguard-home = {
        enable = true;
        httpAddress = config.module.defaults.network.ip;
        httpPort = 3000;

        bindHosts = [
          config.module.defaults.network.ip
          "127.0.0.1"
        ];

        users = [
          {
            name = "maxmur";
            password._secret = "/run/secrets/dnsvm/adguardhome/users/maxmur/password";
          }
        ];

        dnsRewrites = [
          {
            domain = "gitlab.maxmur.info";
            answer = "192.168.1.8";
          }
          {
            domain = "dns.maxmur.info";
            answer = "192.168.1.10";
          }
          {
            domain = "git.maxmur.info";
            answer = "192.168.1.10";
          }
          {
            domain = "vaultwarden.maxmur.info";
            answer = "192.168.1.10";
          }
          {
            domain = "proxmox.maxmur.info";
            answer = "192.168.1.10";
          }
          {
            domain = "paper.maxmur.info";
            answer = "192.168.1.10";
          }
          {
            domain = "home.maxmur.info";
            answer = "192.168.1.10";
          }
          {
            domain = "uptime.maxmur.info";
            answer = "192.168.1.10";
          }
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
