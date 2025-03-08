{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.flameshot;
in {
  options = {
    module.flameshot.enable = mkEnableOption "Enables Flameshot";
  };

  config = mkIf cfg.enable {
    services.flameshot = {
      enable = true;

      settings = {
        General = {
          contrastOpacity = 188;
          disabledTrayIcon = true;
          drawColor = "#00ffff";
          saveAfterCopy = true;
          saveAsFileExtension = "png";
          savePath = "/home/${username}/Pictures/Screenshots";
          savePathFixed = true;
          showDesktopNotification = false;
          showHelp = false;
          showSidePanelButton = false;
          showStartupLaunchMessage = false;
        };

        Shortcuts = {
          TYPE_COPY = "Return";
          TYPE_SAVE = "";
        };
      };
    };
  };
}
