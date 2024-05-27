{ pkgs
, lib
, config
, inputs
, ...
}:

with lib;

let
  cfg = config.module.programs.xdg-portal;
in {
  options = {
    module.programs.xdg-portal.enable = mkEnableOption "Enable xdg-portal";
  };

  config = mkIf cfg.enable {
    /*xdg.portal = {
      enable = true;

      config = {
        hyprland.default = ["gtk" "hyprland"];

        common = {
          default = "gtk";
          "org.freedesktop.impl.portal.Screencast" = "hyprland";
          "org.freedesktop.impl.portal.Screenshot" = "hyprland";
        };
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        inputs.xdghypr.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      ];
    };*/

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = "*";
        # hyprland.default = ["gtk" "hyprland"];
      };

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };
}

