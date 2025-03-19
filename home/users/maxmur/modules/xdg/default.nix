{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.user.xdg;
in {
  options = {
    module.user.xdg.enable = mkEnableOption "Enables xdg";
  };

  config = mkIf cfg.enable {
    xdg = {
      desktopEntries = {
        browser = {
          exec = "${config.module.defaults.browserCmd} %U";
          genericName = "Browser selector";
          name = "browser";
          type = "Application";
          terminal = false;
        };

        editor = {
          exec = "${config.module.defaults.editorCmd} %U";
          genericName = "Editor selector";
          name = "editor";
          type = "Application";
          terminal = true;
        };
      };

      mimeApps = {
        enable = true;

        defaultApplications = {
          "text/markdown" = "editor.desktop";
          "text/plain" = "editor.desktop";
          "text/x-python" = "editor.desktop";

          "text/html" = "browser.desktop";
          "x-scheme-handler/http" = "browser.desktop";
          "x-scheme-handler/https" = "browser.desktop";
          "x-scheme-handler/about" = "browser.desktop";
          "x-scheme-handler/unknown" = "browser.desktop";

          "image/png" = "org.gnome.eog.desktop";
          "image/jpeg" = "org.gnome.eog.desktop";
          "image/jpg" = "org.gnome.eog.desktop";
          "image/svg" = "org.gnome.eog.desktop";

          "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        };
      };
    };
  };
}
