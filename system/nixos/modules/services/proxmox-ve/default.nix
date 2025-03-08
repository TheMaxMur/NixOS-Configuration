{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str;

  cfg = config.module.services.proxmox-ve;
in {
  options.module.services.proxmox-ve = {
    enable = mkEnableOption "Enable module proxmox-ve";

    ipAddress = mkOption {
      type = str;
      default = "";
      description = "IP address for proxmox";
    };
  };

  config = mkIf cfg.enable {
    services.proxmox-ve = {
      enable = true;
      inherit (cfg) ipAddress;
    };
  };
}
