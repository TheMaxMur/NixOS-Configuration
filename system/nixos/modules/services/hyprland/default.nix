{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.hyprland;
in {
  options = {
    module.services.hyprland.enable = mkEnableOption "Enables hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };
}
