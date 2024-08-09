{ lib
, config
, homeModules
, ...
}:

with lib;

let
  cfg = config.module.vscode;
in {
  imports = [
    "${homeModules}/vscode/keybindings"
    "${homeModules}/vscode/extentions"
    "${homeModules}/vscode/settings"
  ];

  options = {
    module.vscode.enable = mkEnableOption "Enables vscode";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
    };
  };
}

