{
  config,
  lib,
  ...
}:

with lib;

let
  cfg = config.module.services.proxmox-ve;
in
{
  options.module.services.proxmox-ve = {
    enable = mkEnableOption "Enable module proxmox-ve";

    ipAddress = mkOption {
      type = types.str;
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
