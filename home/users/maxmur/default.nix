{ isWorkstation
, username
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
    alacritty.enable  = isWorkstation;
    vscode.enable     = isWorkstation;
    doom-emacs.enable = isWorkstation;
    zathura.enable    = isWorkstation;

    chrome.enable       = isLinux && isWorkstation;
    firefox.enable      = isLinux && isWorkstation;
    foot.enable         = isLinux && isWorkstation;
    ssh.enable          = isLinux && isWorkstation;
    impermanence.enable = isLinux && isWorkstation;
    xdg.enable          = isLinux && isWorkstation;

    hyprland.enable = hyprlandEnable && isLinux && isWorkstation;
    sway.enable     = swayEnable && isLinux && isWorkstation;

    hypridle.enable = wmEnable && isLinux && isWorkstation;
    hyprlock.enable = wmEnable && isLinux && isWorkstation;
    waybar.enable   = wmEnable && isLinux && isWorkstation;
    rofi.enable     = wmEnable && isLinux && isWorkstation;
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

    users.${username}.packages.enable = true;
  };
}

