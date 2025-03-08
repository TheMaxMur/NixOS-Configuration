{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.lazygit;
in {
  options = {
    module.lazygit.enable = mkEnableOption "Enables lazygit";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}
