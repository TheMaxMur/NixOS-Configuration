{config, ...}: {
  module = {
    locales.enable = true;
    network.enable = true;
    security.enable = true;
    timedate.enable = true;
    users.enable = true;

    programs = {
      gnupg.enable = true;
      hm.enable = true;
      nh.enable = true;
      mtr.enable = true;
      zsh.enable = true;
      fish.enable = true;
      dconf.enable = true;
      systemPackages.enable = true;
    };

    defaults = {
      network = {
        iface = "end0";
        ip = "192.168.1.8";
        gw = "192.168.1.1";
        mask = "255.255.255.0";
        cidr = "24";
      };

      ssh.pubKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIdsRbzlFB23BdrUzzuBdcDmlkCrdU/620MlH1jdi6vx"
      ];
    };

    services = {
      unbound.enable = true;
      irqbalance.enable = true;

      adguard-home = {
        enable = true;
        httpAddress = "192.168.1.8";

        bindHosts = [
          "192.168.1.8"
          "127.0.0.1"
        ];

        dnsRewrites = [
          {
            domain = "gitlab.maxmur.info";
            anwser = "192.168.1.8";
          }
        ];
      };

      ssh = {
        enable = true;
        listenAddresses = [
          {
            addr = config.module.defaults.network.ip;
            port = 34561;
          }
        ];
      };
    };
  };
}
