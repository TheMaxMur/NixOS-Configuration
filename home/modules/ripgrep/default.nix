{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.ripgrep;
in {
  options = {
    module.ripgrep.enable = mkEnableOption "Enables ripgrep";
  };

  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
    };
  };
}
