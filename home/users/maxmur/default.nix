{ self
, pkgs
, inputs
, config
, generalModules
, homeModules
, isWorkstation
, ...
}:

let
  inherit (pkgs.stdenv) isLinux;
  ufetch = pkgs.callPackage "${self}/pkgs/ufetch" {};
in {
  imports = [
    "${generalModules}"
    "${homeModules}"
    "${homeModules}/ssh"
  ];

  nixpkgs.overlays = [
    (import "${self}/home/overlays/rofi-calc")
    # (import "${self}/home/overlays/rofi-emoji")
  ];

  stylix.targets = {
    vscode.enable = false;
    helix.enable = false;
  };

  module = {
    alacritty.enable  = isWorkstation;
    vscode.enable     = isWorkstation;
    doom-emacs.enable = isWorkstation;
    zathura.enable    = isWorkstation;

    chrome.enable       = isLinux && isWorkstation;
    firefox.enable      = isLinux && isWorkstation;
    foot.enable         = isLinux && isWorkstation;
    ssh.enable          = isLinux && isWorkstation;
    hyprland.enable     = isLinux && isWorkstation;
    impermanence.enable = isLinux && isWorkstation;
    xdg.enable          = isLinux && isWorkstation;

    hypridle.enable  = config.module.hyprland.enable;
    hyprlock.enable  = config.module.hyprland.enable;
    waybar.enable    = config.module.hyprland.enable;
    rofi.enable      = config.module.hyprland.enable;
    swaync.enable    = config.module.hyprland.enable;

    btop.enable           = true;
    eza.enable            = true;
    git.enable            = true;
    fzf.enable            = true;
    htop.enable           = true;
    ripgrep.enable        = true;
    neofetch.enable       = true;
    nvim.enable           = true;
    helix.enable          = true;
    password-store.enable = true;
    zsh.enable            = true;
    fish.enable           = true;
    zoxide.enable         = true;
    yazi.enable           = true;
  };

  home = {
    # Software
    packages = with pkgs; [
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
      # Local
      ufetch

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
      gnome.eog
    ];
  };
}

