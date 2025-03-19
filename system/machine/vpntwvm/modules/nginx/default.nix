_: {
  users.users.nginx.extraGroups = ["acme"];

  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedTlsSettings = true;

    clientMaxBodySize = "5G";

    virtualHosts = {
      "auth.ext.maxmur.info" = {
        forceSSL = true;
        useACMEHost = "ext.maxmur.info";

        locations."/" = {
          proxyPass = "http://127.0.0.1:8000";
        };
      };

      "netbird.ext.maxmur.info" = {
        forceSSL = true;
        useACMEHost = "ext.maxmur.info";
      };

      "paste.ext.maxmur.info" = {
        forceSSL = true;
        useACMEHost = "ext.maxmur.info";
      };
    };
  };
}
