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
        iface = "vm5";
        ip = "10.0.0.5";
        gw = "10.0.0.0";
        mask = "255.255.255.0";
        cidr = "24";
        mac = "02:00:02:00:00:00";
      };

      ssh.pubKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWJULtMSQfTZqoXwfK32T+V+NZMqM+1rKhURlee8yS+ maxmur"
      ];
    };

    services = {
      fail2ban.enable = true;

      vaultwarden = {
        enable = true;
        dbBackend = "postgresql";
        environmentFile = "/run/secrets/vaultwarden/env";

        config = {
          DATA_FOLDER = "/var/lib/vaultwarden";
          DOMAIN = "https://vaultwarden.maxmur.info";
          ROCKET_ADDRESS = "0.0.0.0";
          ROCKET_PORT = 8001;
          SIGNUPS_ALLOWED = false;
          WEB_VAULT_ENABLED = true;
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
