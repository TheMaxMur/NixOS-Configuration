{
  self,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.vscode;
in {
  imports = [
    "${self}/home/modules/vscode/keybindings"
    "${self}/home/modules/vscode/extentions"
    "${self}/home/modules/vscode/settings"
  ];

  options = {
    module.vscode.enable = mkEnableOption "Enables vscode";
  };

  config = mkIf cfg.enable {
    programs.vscode.profiles.default = {
      enable = true;
      enableUpdateCheck = false;
    };
  };
}
