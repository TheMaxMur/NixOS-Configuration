{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.programs.fish;
in {
  options = {
    module.programs.fish.enable = mkEnableOption "Enable fish";
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
  };
}
