{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.programs.fish;
in
{
  options = {
    module.programs.fish.enable = mkEnableOption "Enable fish";
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
  };
}
