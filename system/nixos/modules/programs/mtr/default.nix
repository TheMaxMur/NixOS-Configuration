{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.programs.mtr;
in
{
  options = {
    module.programs.mtr.enable = mkEnableOption "Enable mtr";
  };

  config = mkIf cfg.enable {
    programs.mtr.enable = true;
  };
}
