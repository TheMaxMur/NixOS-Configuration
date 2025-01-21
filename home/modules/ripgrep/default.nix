{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.ripgrep;
in
{
  options = {
    module.ripgrep.enable = mkEnableOption "Enables ripgrep";
  };

  config = mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
    };
  };
}
