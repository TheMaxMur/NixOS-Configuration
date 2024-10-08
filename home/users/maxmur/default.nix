{ isWorkstation
, isLinux
, hyprlandEnable ? false
, swayEnable ? false
, wmEnable ? false
, ...
}:

{
  nixpkgs.overlays = [  ];

  stylix.targets = {
    vscode.enable = false;
    helix.enable = false;
  };

  module = {
    alacritty.enable = isWorkstation;
    vscode.enable    = isWorkstation;
    emacs.enable     = isWorkstation;
    zathura.enable   = isWorkstation;
    stylix.enable    = isWorkstation;

    chrome.enable      = isLinux && isWorkstation;
    firefox.enable     = isLinux && isWorkstation;
    librewolf.enable   = isLinux && isWorkstation;
    thunderbird.enable = isLinux && isWorkstation;
    foot.enable        = isLinux && isWorkstation;
    ssh.enable         = isLinux && isWorkstation;

    hyprland.enable = hyprlandEnable && isLinux && isWorkstation;
    hyprlock.enable = hyprlandEnable && isLinux && isWorkstation;

    sway.enable     = swayEnable && isLinux && isWorkstation;
    swaylock.enable = swayEnable && isLinux && isWorkstation;

    hypridle.enable = wmEnable && isLinux && isWorkstation;
    waybar.enable   = wmEnable && isLinux && isWorkstation;
    fuzzel.enable   = wmEnable && isLinux && isWorkstation;
    swaync.enable   = wmEnable && isLinux && isWorkstation;

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

    user = {
      impermanence.enable = isLinux && isWorkstation;
      xdg.enable          = isLinux && isWorkstation;

      packages.enable = true;
    };
  };
}

