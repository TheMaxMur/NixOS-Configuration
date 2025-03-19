{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkForce;

  cfg = config.module.services.uptime-kuma;
in {
  options = {
    module.services.uptime-kuma = {
      enable = mkEnableOption "Enables uptime-kuma";
    };
  };

  config = mkIf cfg.enable {
    services.uptime-kuma = {
      enable = true;

      settings = {
        DATA_DIR = "/var/lib/uptime-kuma/";
        PORT = "64901";
        HOST = "127.0.0.1";
      };
    };

    systemd.services.uptime-kuma = {
      serviceConfig = {
        DynamicUser = mkForce false;
      };
    };
  };
}
