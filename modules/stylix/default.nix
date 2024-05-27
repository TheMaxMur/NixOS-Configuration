{ inputs
, pkgs
, config
, hostname
, ...
}: 

let
  theme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  wallpaper = ../../assets/grey_gradient.png;
  cursorSize = if hostname == "nbox" then 24 else 14;
in {
  stylix = {
    image = wallpaper;
    autoEnable = true;
    polarity = "dark";

    base16Scheme = theme;

    opacity = {
      applications = 1.0;
      terminal     = 1.0;
      popups       = 1.0;
      desktop      = 1.0;
    };

    cursor = {
      name    = "Vimix-cursors";
      package = pkgs.vimix-cursors;
      size    = cursorSize;
    };

    fonts = {
      sizes = {
        applications = 10;
        terminal     = 10;
        popups       = 10;
        desktop      = 10;
      };

      serif = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        name    = "JetBrains Mono Nerd Font";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        name    = "JetBrainsMono Nerd Font Mono";
      };

      emoji     = config.stylix.fonts.serif;
    };
  };
}

