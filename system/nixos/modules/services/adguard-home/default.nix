{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.services.adguard-home;
in
{
  options = {
    module.services.adguard-home = {
      enable = mkEnableOption "Enables adguard-home";

      httpAddress = mkOption {
        type = types.str;
        default = "0.0.0.0";
      };

      bindHosts = mkOption {
        type = types.listOf types.str;
        default = [ "0.0.0.0" ];
      };

      dnsRewrites = mkOption {
        type = types.listOf types.attrs;
        default = [ ];
      };
    };
  };

  config = mkIf cfg.enable {
    services.adguardhome = {
      enable = true;
      port = 3000;
      mutableSettings = true;

      settings = {
        auth_attempts = 3;
        block_auth_min = 5;
        http.address = "${cfg.httpAddress}:3000";
        dhcp.enabled = false;

        statistics = {
          enabled = true;
          interval = "8760h";
        };

        dns = {
          bind_hosts = cfg.bindHosts;
          ratelimit = 0;
          rewrites = cfg.dnsRewrites;

          upstream_dns = [
            "tls://dns.google"
            "tls://common.dot.dns.yandex.net"
          ];

          bootstrap_dns = [
            "9.9.9.10"
            "149.112.112.10"
          ];
        };
      };
    };
  };
}
