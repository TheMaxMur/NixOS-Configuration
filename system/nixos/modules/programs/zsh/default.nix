{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.programs.zsh;
in {
  options = {
    module.programs.zsh.enable = mkEnableOption "Enable zsh";
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;
  };
}
