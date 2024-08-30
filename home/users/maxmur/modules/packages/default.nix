{ config
, lib
, pkgs
, inputs
, isWorkstation
, wmEnable
, ...
}:

with lib;

let
  inherit (pkgs.stdenv) isLinux;
  cfg = config.module.users.maxmur.packages;
in {
  options.module.users.maxmur.packages = {
    enable = mkEnableOption "Enable maxmur packages";
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
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
    ] ++ lib.optionals isWorkstation [
      # Chats
      discord

      # Text Editors
      obsidian

      # Security
      semgrep
      grype
      syft

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" "UbuntuMono" "Iosevka" ]; })
      corefonts
    ] ++ lib.optionals (isLinux && isWorkstation) [
      # Programming
      go
      python3

      # DevOps Utils
      docker-compose
      kubectl
      kubernetes-helm
      ansible
      ansible-lint
      terraform
      vagrant

      # Chats
      telegram-desktop
      vesktop

      # Office
      onlyoffice-bin

      # Misc
      obs-studio
      dconf2nix
      via
      gpick
      gat
      vlc
      eog
    ] ++ lib.optionals wmEnable [
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
      nemo
      eww
      networkmanagerapplet
      brightnessctl
    ];
  };
}

