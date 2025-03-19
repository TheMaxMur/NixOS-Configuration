{config, ...}: {
  module = {
    boot.enable = true;
    timedate.enable = true;
    locales.enable = true;
    users.enable = true;
    network.enable = true;
    variables.enable = true;
    stylix.enable = true;
    nixos-ng.enable = true;
    minimal.enable = true;

    programs = {
      gnupg.enable = true;
      fish.enable = true;
      zsh.enable = true;
      systemPackages.enable = true;
    };

    security = {
      enable = true;
      enableBootOptions = true;
    };

    defaults = {
      network = {
        iface = "enp0s31f6";
        ip = "192.168.1.10";
        gw = "192.168.1.1";
        mask = "255.255.255.0";
        cidr = "24";
      };

      ssh.pubKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXByEG3SJJOMxKEAl8azfR/fNMuvXfNcCaEFrdIdn91"
      ];
    };

    services = {
      fail2ban.enable = true;
      irqbalance.enable = true;
      netbird.enable = true;
      homepage-dashboard.enable = true;
      uptime-kuma.enable = true;

      proxmox-ve = {
        enable = true;
        ipAddress = config.module.defaults.network.ip;
      };

      ssh = {
        enable = true;
        listenAddresses = [
          {
            addr = config.module.defaults.network.ip;
            port = 45631;
          }
        ];
      };
    };
  };

  nix.settings.trusted-users = [
    "maxmur"
    "root"
  ];
}
