_: {
  users.users.nginx.extraGroups = ["acme"];

  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedTlsSettings = true;
    eventsConfig = "worker_connections 200000;";

    clientMaxBodySize = "5G";

    streamConfig = ''
      server {
        listen 4224;
        proxy_pass 10.0.0.4:4224;
      }
    '';

    virtualHosts = {
      "dns.maxmur.info" = {
        forceSSL = true;
        useACMEHost = "maxmur.info";

        locations."/" = {
          proxyPass = "http://10.0.0.2:3000";
        };
      };

      "git.maxmur.info" = {
        forceSSL = true;
        useACMEHost = "maxmur.info";

        locations."/" = {
          proxyPass = "http://10.0.0.4:3000";
        };
      };

      "vaultwarden.maxmur.info" = {
        forceSSL = true;
        useACMEHost = "maxmur.info";

        locations."/" = {
          proxyPass = "http://10.0.0.5:8001";
        };
      };

      "proxmox.maxmur.info" = {
        forceSSL = true;
        useACMEHost = "maxmur.info";

        locations."/" = {
          proxyPass = "https://192.168.1.10:8006";
        };
      };

      "home.maxmur.info" = {
        forceSSL = true;
        useACMEHost = "maxmur.info";

        locations."/" = {
          proxyPass = "http://127.0.0.1:8082";
        };
      };

      "uptime.maxmur.info" = {
        forceSSL = true;
        useACMEHost = "maxmur.info";

        locations."/" = {
          proxyPass = "http://127.0.0.1:64901";
        };
      };
    };
  };
}
