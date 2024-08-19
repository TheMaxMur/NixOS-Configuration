{ config
, lib
, pkgs
, inputs
, isWorkstation
, ...
}:

with lib;

let
  inherit (pkgs.stdenv) isLinux;
  cfg = config.module.users.maxmur.packages;
in {
  options.module.users.maxmur.packages = {
    enable = mkEnableOption "Enable maxmur packages";
    wmEnable = mkEnableOption "Enable packages for wm";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Utils
      bat
      tokei
      shellcheck
      pre-commit
      deadnix
      statix
      # eza
      ffmpeg
      inputs.any-nix-shell

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

      # Security
      age
      sops
      grype
      syft
    ] ++ lib.optionals isWorkstation [
      # Chats
      discord

      # Text Editors
      obsidian

      # Security
      semgrep
    ] ++ lib.optionals (isLinux && isWorkstation) [
     # DevOps Utils
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
    ] ++ lib.optionals cfg.wmEnable [
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

