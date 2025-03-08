{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.password-store;
in {
  options = {
    module.password-store.enable = mkEnableOption "Enables password-store";
  };

  config = mkIf cfg.enable {
    programs.password-store = {
      enable = true;

      settings = {
        PASSWORD_STORE_DIR = "$HOME/.password-store";
      };
    };
  };
}
