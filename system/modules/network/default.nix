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
    module.network.enable = mkEnableOption "Enables network";
  };

  config = mkIf cfg.enable {
    systemd.services.NetworkManager-wait-online.enable = false;

    networking = {
      networkmanager.enable = true;
      networkmanager.wifi.macAddress = "random";
      useDHCP = mkDefault true;
      hostName = hostname;
    };
  };
}

