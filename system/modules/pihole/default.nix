{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.pihole;
in {
  options = {
    module.pihole.enable = mkEnableOption "Enables pihole";
  };

  config = mkIf cfg.enable {
    services.unbound = {
      enable = true;

      settings.server = {
        port = "5335";
        auto-trust-anchor-file = "/var/lib/unbound/root.key";
        root-hints = "/var/lib/unbound/root.hints";
        verbosity = "0";
        interface = "172.17.0.1";
        do-ip4 = "yes";
        do-udp = "yes";
        do-tcp = "yes";
        do-ip6 = "no";
        prefer-ip6 = "no";
        harden-glue = "yes";
        harden-dnssec-stripped = "yes";
        use-caps-for-id  = "no";
        edns-buffer-size = "1232";
        prefetch = "yes";
        num-threads = "1";
        so-rcvbuf = "1m";

        access-control = [
          "192.168.1.0/24 allow"
          "172.16.0.0/12 allow"
          "127.0.0.0/8 allow"
          "10.0.0.0/8 allow"
        ];

        private-address = [
          "192.168.0.0/16"
          "169.254.0.0/16"
          "172.16.0.0/12"
          "127.0.0.0/8"
          "10.0.0.0/8"
        ];
      };
    };

    virtualisation.oci-containers = {
      backend = "docker";

      containers.pihole = {
        autoStart = true;
        image = "pihole/pihole:2024.03.2";

        extraOptions = [
          "--cap-add=NET_ADMIN"
        ];

        volumes = [
          "/opt/pihole/etc-pihole:/etc/pihole"
          "/opt/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
          "/opt/pihole/log:/var/log/pihole"
        ];

        environment = {
          TZ = "Europe/Moscow";
          CUSTOM_CACHE_SIZE = "0";
          PIHOLE_DNS_ = "172.17.0.1#5335";
          DNSSEC = "true";
          REV_SERVER = "false";
          # VIRTUAL_HOST = "pihole.${hostName}.meurer.org";
          WEBTHEME = "default-darker";
          DNSMASQ_USER = "root";
          DNSMASQ_LISTENING = "all";
          FTLCONF_REPLY_ADDR4 = "192.168.1.8";
        };

        ports = [
          "53:53/tcp"
          "53:53/udp"
          "8053:80/tcp"
        ];
      };
    };

    systemd.services.docker-pihole = {
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
    };
  };
}

