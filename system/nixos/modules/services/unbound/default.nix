{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.unbound;
in {
  options = {
    module.services.unbound = {
      enable = mkEnableOption "Enables unbound";
    };
  };

  config = mkIf cfg.enable {
    services.unbound = {
      enable = true;

      settings.server = {
        port = "5335";
        auto-trust-anchor-file = "/var/lib/unbound/root.key";
        root-hints = "/var/lib/unbound/root.hints";
        verbosity = "0";
        interface = "0.0.0.0";
        do-ip4 = "yes";
        do-udp = "yes";
        do-tcp = "yes";
        do-ip6 = "no";
        prefer-ip6 = "no";
        harden-glue = "yes";
        harden-dnssec-stripped = "yes";
        use-caps-for-id = "no";
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
  };
}
