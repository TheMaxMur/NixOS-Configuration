{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.fzf;
in {
  options = {
    module.fzf.enable = mkEnableOption "Enables fzf";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultOptions = [
        "--border"
        "--preview 'bat --color=always {}'"
        "--prompt 'Files> '"
      ];
    };
  };
}
