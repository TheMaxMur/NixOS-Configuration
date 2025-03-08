{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.programs.dconf;
in {
  options = {
    module.programs.dconf.enable = mkEnableOption "Enable dconf";
  };

  config = mkIf cfg.enable {
    programs.dconf.enable = true;
  };
}
