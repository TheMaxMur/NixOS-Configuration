{ lib
, config
, hostname
, ...
}:

with lib;

let
  cfg = config.module.network;
in {
  options = {
    module.network = {
      enable = mkEnableOption "Enables network";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.services.systemd-networkd-wait-online.enable = mkForce false;

    systemd.network.enable = true;

    networking = {
      firewall = {
        enable = true;
      };

      networkmanager = {
        enable = true;
        wifi.macAddress = "random";
        wifi.backend = "iwd";
      };

      wireless.iwd = {
        enable = true;

        settings = {
          Settings = {
            AutoConnect = true;
          };
        };
      };

      useDHCP = mkDefault true;
      hostName = hostname;
    };
  };
}

