{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str listOf package;

  cfg = config.module.services.postgresql;
in {
  options = {
    module.services.postgresql = {
      enable = mkEnableOption "Enable postgresql";

      package = mkOption {
        type = package;
        default = pkgs.postgresql_17;
        description = "Postgresql package";
      };

      configurations = mkOption {
        type = listOf str;
        default = [];
        description = "Creates users and database";
      };

      dataDir = mkOption {
        type = str;
        default = "/var/lib/postgresql/";
        description = "DB data dir";
      };

      authentication = mkOption {
        type = str;
        default = "local all all trust";
        description = "Auth settings";
      };

      enableTCPIP = mkEnableOption "Listen all interfaces";
    };
  };

  config = mkIf cfg.enable {
    services.postgresql = let
      inherit (cfg) configurations;

      ensureDatabases = ["root"] ++ configurations;

      ensureUsers =
        map (name: {
          inherit name;
          ensureDBOwnership = true;
          ensureClauses =
            if name == "root"
            then {
              createdb = true;
              createrole = true;
              superuser = true;
            }
            else {};
        })
        ensureDatabases;
    in {
      inherit ensureDatabases ensureUsers;
      inherit (cfg) dataDir authentication enableTCPIP package;

      enable = true;
    };
  };
}
