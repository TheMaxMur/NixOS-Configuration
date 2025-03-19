{
  pkgs,
  lib,
  self,
  config,
  hostname,
  theme,
  stateVersion,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib) optionalAttrs;
  inherit (lib.types) bool;

  cfg = config.module.stylix;

  cursorSize =
    if hostname == "nbox"
    then 24
    else 14;

  iosevkaPackage =
    if stateVersion == "24.11"
    then pkgs.nerdfonts.override {fonts = ["Iosevka"];}
    else pkgs.nerd-fonts.iosevka;
  jbPackage =
    if stateVersion == "24.11"
    then pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];}
    else pkgs.nerd-fonts.iosevka;

  themes = {
    nord = {
      scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      wallpaper = "${self}/assets/grey_gradient.png";

      font = {
        package = iosevkaPackage;
        name = "Iosevka Nerd Font Mono";
      };

      cursor = {
        name = "Vimix-cursors";
        package = pkgs.vimix-cursors;
      };
    };

    gruvbox = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
      wallpaper = "${self}/assets/grey_gradient.png";

      font = {
        package = jbPackage;
        name = "JetBrains Mono Nerd Font";
      };

      cursor = {
        package = pkgs.material-cursors;
        name = "material_dark_cursors";
      };
    };
  };
in {
  options = {
    module.stylix = {
      enable = mkEnableOption "Enables stylix";

      useCursor = mkOption {
        type = bool;
        default = true;
        description = "Enable cursor settings";
      };
    };
  };

  config = mkIf cfg.enable {
    stylix =
      {
        enable = true;
        image = themes.${theme}.wallpaper;
        autoEnable = true;
        polarity = "dark";
        base16Scheme = themes.${theme}.scheme;

        opacity = {
          applications = 1.0;
          terminal = 1.0;
          popups = 1.0;
          desktop = 1.0;
        };

        fonts = {
          sizes = {
            applications = 11;
            terminal = 11;
            popups = 12;
            desktop = 11;
          };

          serif = {
            inherit (themes.${theme}.font) package name;
          };

          sansSerif = config.stylix.fonts.serif;
          monospace = config.stylix.fonts.serif;
          emoji = config.stylix.fonts.serif;
        };
      }
      // optionalAttrs cfg.useCursor {
        cursor = {
          inherit (themes.${theme}.cursor) package name;
          size = cursorSize;
        };
      };
  };
}
