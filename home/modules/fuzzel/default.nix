{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.fuzzel;
in {
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
