{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.zoxide;
in
{
  options = {
    module.zoxide.enable = mkEnableOption "Enables zoxide";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
