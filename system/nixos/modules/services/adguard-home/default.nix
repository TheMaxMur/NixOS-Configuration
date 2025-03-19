{
  lib,
  config,
  utils,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption mkForce;
  inherit (lib.types) str listOf attrs int;
  inherit (utils) genJqSecretsReplacementSnippet;

  genYqSecretsReplacementSnippet = attrs: fileIn: fileOut:
    (genJqSecretsReplacementSnippet attrs fileIn)
    + ''
      ${pkgs.yq-go}/bin/yq -Poy ${fileIn} > ${fileOut}
      chmod 600 ${fileOut}
      rm -f ${fileIn}
    '';

  cfg = config.module.services.adguard-home;
in {
  options = {
    module.services.adguard-home = {
      enable = mkEnableOption "Enables adguard-home";

      httpAddress = mkOption {
        type = str;
        default = "0.0.0.0";
      };

      httpPort = mkOption {
        type = int;
        default = 3000;
      };

      bindHosts = mkOption {
        type = listOf str;
        default = ["0.0.0.0"];
      };

      dnsRewrites = mkOption {
        type = listOf attrs;
        default = [];
      };

      users = mkOption {
        type = listOf attrs;
        default = [];
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.adguardhome = {
      preStart = mkForce (genYqSecretsReplacementSnippet config.services.adguardhome.settings "/var/lib/AdGuardHome/AdGuardHome.json" "/var/lib/AdGuardHome/AdGuardHome.yaml");

      serviceConfig = {
        DynamicUser = mkForce false;

        # hardening
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        PrivateMounts = true;
        PrivateTmp = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectSystem = true;
        RemoveIPC = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
      };
    };

    services.adguardhome = {
      enable = true;
      port = cfg.httpPort;
      mutableSettings = true;

      settings = {
        inherit (cfg) users;

        auth_attempts = 3;
        block_auth_min = 5;
        http.address = "${cfg.httpAddress}:${builtins.toString cfg.httpPort}";
        dhcp.enabled = false;

        statistics = {
          enabled = true;
          interval = "8760h";
        };

        filtering = {
          rewrites = cfg.dnsRewrites;
        };

        dns = {
          bind_hosts = cfg.bindHosts;
          ratelimit = 0;

          upstream_dns = [
            "tls://dns.google"
            "tls://cloudflare-dns.com"
            "tls://dns.quad9.net"
          ];

          bootstrap_dns = [
            "8.8.8.8"
            "8.8.4.4"
          ];
        };

        filters = [
          {
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
            name = "AdGuard DNS filter";
            id = 1;
            enabled = true;
          }
          {
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt";
            name = "AdAway Default Blocklist";
            id = 2;
            enabled = true;
          }
          {
            url = "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt";
            name = "Windows telemetry v4";
            id = 3;
            enabled = true;
          }
          {
            url = "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/refs/heads/master/data/hosts/spy_v6.txt";
            name = "Windows telemetry v6";
            id = 4;
            enabled = true;
          }
          {
            url = "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/refs/heads/master/data/hosts/extra.txt";
            name = "Windows extra v4";
            id = 5;
            enabled = true;
          }
          {
            url = "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/refs/heads/master/data/hosts/extra_v6.txt";
            name = "Windows extra v6";
            id = 6;
            enabled = true;
          }
        ];
      };
    };
  };
}
