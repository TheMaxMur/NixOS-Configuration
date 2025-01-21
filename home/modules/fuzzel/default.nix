{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.fuzzel;
in
{
  options = {
    module.fuzzel = {
      enable = mkEnableOption "Enable fuzzel app runner";
    };
  };

  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
    };
  };
}
