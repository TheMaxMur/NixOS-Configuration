{
  config,
  lib,
  pkgs,
  inputs,
  isWorkstation,
  wmEnable,
  ...
}:

with lib;

let
  inherit (pkgs.stdenv) isLinux;
  cfg = config.module.user.packages;
in
{
  options.module.user.packages = {
    enable = mkEnableOption "Enable user packages";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages =
      with pkgs;
      [
        # Utils
        bat
        tokei
        shellcheck
        pre-commit
        deadnix
        statix
        ffmpeg
        inputs.any-nix-shell

        # Security
        age
        sops
      ]
      ++ lib.optionals isWorkstation [
        # Text Editors
        obsidian

        # Fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.ubuntu-mono
        nerd-fonts.iosevka
        corefonts
      ]
      ++ lib.optionals (isLinux && isWorkstation) [
        inputs.ghostty.packages.x86_64-linux.default
        # Programming
        go
        python3

        # DevOps Utils
        docker-compose
        kubectl
        kubernetes-helm
        ansible
        ansible-lint

        # Chats
        telegram-desktop
        fluffychat
        vesktop

        # Office
        onlyoffice-bin

        # Misc
        obs-studio
        dconf2nix
        via
        gat
        vlc
        eog
      ]
      ++ lib.optionals wmEnable [
        imagemagick
        grim
        slurp
        wl-clipboard
        wf-recorder
        hyprpicker
        waypaper
        cliphist
        imv
        gtk3
        dbus
        glib
        swww
        xdg-utils
        pavucontrol
        xfce.thunar
        eww
        networkmanagerapplet
        brightnessctl
      ];
  };
}
