{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.btop;
in {
  options = {
    module.btop.enable = mkEnableOption "Enables btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
    };
  };
}
