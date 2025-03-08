{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.programs.kdeconnect;
in {
  options = {
    module.programs.kdeconnect.enable = mkEnableOption "Enable kdeconnect";
  };

  config = mkIf cfg.enable {
    programs.kdeconnect.enable = true;
  };
}
