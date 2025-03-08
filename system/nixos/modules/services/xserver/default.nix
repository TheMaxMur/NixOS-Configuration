{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.xserver;
in {
  options = {
    module.services.xserver.enable = mkEnableOption "Enable xserver";
  };

  config = mkIf cfg.enable {
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      oxygen
    ];

    # programs.hyprland.enable = true;
    # services.xserver.displayManager.gdm.enable = true;
    # services.xserver.desktopManager.gnome.enable = true;
    # environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
    # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    services = {
      desktopManager.plasma6.enable = true;
      displayManager = {
        sddm.enable = true;
        defaultSession = "plasma";
      };

      xserver = {
        enable = true;
        libinput.enable = true;

        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}
