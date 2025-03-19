{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.fail2ban;
in {
  options = {
    module.services.fail2ban = {
      enable = mkEnableOption "Enable fail2ban";
    };
  };

  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
    };
  };
}
