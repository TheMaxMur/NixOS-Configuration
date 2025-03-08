{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.pihole;
in {
  options = {
    module.pihole.enable = mkEnableOption "Enables pihole";
  };

  config = mkIf cfg.enable {
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
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
    };
  };
}
