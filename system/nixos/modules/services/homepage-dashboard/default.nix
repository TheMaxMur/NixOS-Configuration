{
  lib,
  config,
  self,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.homepage-dashboard;
in {
  imports = [
    "${self}/system/nixos/modules/services/homepage-dashboard/settings"
    "${self}/system/nixos/modules/services/homepage-dashboard/services"
  ];

  options = {
    module.services.homepage-dashboard = {
      enable = mkEnableOption "Enables homepage-dashboard";
    };
  };

  config = mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      listenPort = 8082;
    };
  };
}
