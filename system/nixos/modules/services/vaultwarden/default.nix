{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str attrs oneOf path;

  cfg = config.module.services.vaultwarden;
in {
  options = {
    module.services.vaultwarden = {
      enable = mkEnableOption "Enable vaultwarden";

      dbBackend = mkOption {
        type = str;
        default = "sqlite";
        description = "Db type for vaultwarden";
      };

      environmentFile = mkOption {
        type = oneOf [str path];
        default = "/run/secrets/vaultwarden/env";
        description = "Secrets in env for vaultwarden";
      };

      config = mkOption {
        type = attrs;
        default = {};
        description = "Vaultwarden env";
      };
    };
  };

  config = mkIf cfg.enable {
    services.vaultwarden = {
      inherit (cfg) dbBackend environmentFile config;

      enable = true;
    };
  };
}
