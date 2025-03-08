{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.homepage-dashboard;
in {
  options = {
    module.services.homepage-dashboard = {
      enable = mkEnableOption "Enables homepage-dashboard";
    };
  };

  config = mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      package = pkgs.homepage-dashboard;
    };

    /*
    systemd.services.homepage-dashboard.environment.HOMEPAGE_CONFIG_DIR = let
      configDir = pkgs.linkFarm "homepage-dashboard-config" {
        "settings.yaml" = yaml.generate "settings.yaml" {
          title = "Germond Homelab";
          background = "https://images.unsplash.com/photo-1502790671504-542ad42d5189?auto=format&fit=crop&w=2560&q=80";
          cardBlur = "sm";
          theme = "dark";
          color = "zinc";
          iconStyle = "theme";
          statusStyle = "dot";

          language = "fr";

          target = "_blank"; # open links in new tabs

          hideVersion = true;
          disableCollapse = true;

          logpath = pkgs.linkFarm "homepage-dashboard-null-logs" {
            "logs/homepage.log" = "/dev/null";
          };
        };
        "services.yaml" = yaml.generate "services.yaml" [];
        "widgets.yaml" = yaml.generate "widgets.yaml" [];
        "bookmarks.yaml" = yaml.generate "bookmarks.yaml" [];
        "docker.yaml" = yaml.generate "docker.yaml" {};
        "kubernetes.yaml" = yaml.generate "kubernetes.yaml" {
          mode = "disabled";
        };
        "custom.css" = pkgs.writeText "custom.css" '''';
        "custom.js" = pkgs.writeText "custom.js" '''';
      };
    in
      lib.mkForce "${configDir}";
    */
  };
}
