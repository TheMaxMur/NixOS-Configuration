{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) attrs;

  cfg = config.module.services.keycloak;
in {
  options = {
    module.services.keycloak = {
      enable = mkEnableOption "Enables keycloak";

      database = mkOption {
        type = attrs;
        default = {};
        description = "Settings of databese";
      };

      settings = mkOption {
        type = attrs;
        default = {};
        description = "Keycloak settings";
      };
    };
  };

  config = mkIf cfg.enable {
    services.keycloak = {
      inherit (cfg) database settings;

      enable = true;
    };
  };
}
