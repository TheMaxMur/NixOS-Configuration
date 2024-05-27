{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.vscode;
in {
  imports = [
    ./keybindings
    ./extentions
    ./settings
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

