{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str;

  cfg = config.module.services.scx;
in {
  options = {
    module.services.scx = {
      enable = mkEnableOption "Enables scx module";

      schedulerType = mkOption {
        type = str;
        default = "scx_rustland";
      };
    };
  };

  config = mkIf cfg.enable {
    services.scx = {
      enable = true;
      scheduler = cfg.schedulerType;
    };
  };
}
