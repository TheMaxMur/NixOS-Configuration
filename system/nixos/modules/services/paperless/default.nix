{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str attrs;

  cfg = config.module.services.paperless;
in {
  options = {
    module.services.paperless = {
      enable = mkEnableOption "Enables paperless";

      listenAddress = mkOption {
        type = str;
        default = "0.0.0.0";
        description = "Listen web address";
      };

      settings = mkOption {
        type = attrs;
        default = {};
        description = "Paperless settings";
      };
    };
  };

  config = mkIf cfg.enable {
    services.paperless = {
      inherit (cfg) settings;

      enable = true;
      address = cfg.listenAddress;
      passwordFile = pkgs.writeText "PaperlessPassword" "root"; # WARN: Only for initial setup, change later.
    };
  };
}
