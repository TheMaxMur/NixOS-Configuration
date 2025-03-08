{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkForce;

  cfg = config.module.user.variables;
in {
  options = {
    module.user.variables.enable = mkEnableOption "Enables variables";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      QT_QPA_PLATFORMTHEME = mkForce "gtk3";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
      MOZ_LEGACY_PROFILES = "1";
    };
  };
}
