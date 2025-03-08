{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str int;

  cfg = config.module.zapret;
in {
  options = {
    module.zapret = {
      enable = mkEnableOption "Enables zapret";

      wan = mkOption {
        type = str;
        default = "eth0";
        description = "";
      };

      qnum = mkOption {
        type = int;
        default = 200;
        description = "";
      };
    };
  };

  config = mkIf cfg.enable {
    boot.kernel.sysctl = {
      "net.ipv4.conf.all.src_valid_mark" = 1;
      "net.ipv4.ip_forward" = 1;
    };

    networking = {
      firewall = {
        extraCommands = ''
          iptables -t mangle -I POSTROUTING -o "${cfg.wan}" -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num ${toString cfg.qnum} --queue-bypass
        '';
      };
    };

    systemd = {
      services = {
        zapret = {
          description = "gigi za shagi";
          wantedBy = ["multi-user.target"];
          requires = ["network.target"];

          serviceConfig = {
            ExecStart = "${pkgs.zapret}/bin/nfqws --pidfile=/run/nfqws.pid --dpi-desync=fake --dpi-desync=disorder --dpi-desync=split2 --dpi-desync-ttl=1 --dpi-desync-repeats=6 --dpi-desync-autottl=3 --wssize 1:6 --dpi-desync-fake-tls=0x00000000 --dpi-desync-split-pos=1 --qnum=${toString cfg.qnum}";
            Type = "forking";
            PIDFile = "/run/nfqws.pid";
            ExecReload = "/bin/kill -HUP $MAINPID";
            Restart = "always";
            RestartSec = "5s";
          };
        };
      };
    };
  };
}
