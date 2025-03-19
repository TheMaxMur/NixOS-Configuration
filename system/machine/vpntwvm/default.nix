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
        iface = "ens3";
        ip = "37.252.22.10";
        gw = "37.252.22.1";
        mask = "255.255.255.0";
        cidr = "24";
      };

      ssh.pubKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0MrNpS4NvXUqEJdo8wHHb3l6TKsgWxkSWzlWKiX+WU maxmur"
      ];
    };

    services = {
      fail2ban.enable = true;

      postgresql = {
        enable = true;
        dataDir = "/var/lib/postgresql/17";
        authentication = "host all all 0.0.0.0/0 scram-sha-256";

        configurations = [
          "keycloak"
        ];
      };

      keycloak = {
        enable = true;

        database = {
          type = "postgresql";
          username = "keycloak";
          name = "keycloak";
          host = "localhost";
          passwordFile = config.sops.secrets."db/keycloakUser".path;
        };

        settings = {
          hostname = "auth.ext.maxmur.info";
          http-enabled = true;
          http-port = 8000;
          http-host = "127.0.0.1";
          http-relative-path = "/auth";
          proxy-headers = "xforwarded";
        };
      };

      netbird-server = {
        enable = true;
        domain = "netbird.ext.maxmur.info";
        clientID = "netbird-client";
        backendID = "netbird-backend";
        keycloakDomain = "auth.ext.maxmur.info";
        keycloakURL = "https://auth.ext.maxmur.info/auth";
        keycloakRealmName = "homelab";
        coturnPasswordPath = config.sops.secrets."netbird/coturnPassword".path;
        coturnSalt = config.sops.secrets."netbird/coturnSalt".path;
        dataStoreEncryptionKeyPath = config.sops.secrets."netbird/dataStoreEncryptionKey".path;
        clientSecretPath = config.sops.secrets."netbird/clientSecret".path;
      };

      privatebin = {
        enable = true;
        domain = "paste.ext.maxmur.info";
        name = "maxmur pastebin";
      };

      ssh = {
        enable = true;
        listenAddresses = [
          {
            addr = "0.0.0.0";
            port = 54315;
          }
        ];
      };
    };
  };
}
