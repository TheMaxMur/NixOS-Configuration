{
  isWorkstation,
  isLinux,
  hyprlandEnable ? false,
  swayEnable ? false,
  wmEnable ? false,
  ...
}: {
  stylix.targets = {
    vscode.enable = false;
    helix.enable = false;
  };

  module = {
    alacritty.enable = isWorkstation;
    vscode.enable = isWorkstation;
    emacs.enable = isWorkstation;
    zathura.enable = isWorkstation;
    stylix.enable = isWorkstation;

    chromium.enable = isLinux && isWorkstation;
    librewolf.enable = isLinux && isWorkstation;
    thunderbird.enable = isLinux && isWorkstation;
    foot.enable = isLinux && isWorkstation;

    hyprland.enable = hyprlandEnable && isLinux && isWorkstation;
    hyprlock.enable = hyprlandEnable && isLinux && isWorkstation;

    sway.enable = swayEnable && isLinux && isWorkstation;
    swaylock.enable = swayEnable && isLinux && isWorkstation;

    hypridle.enable = wmEnable && isLinux && isWorkstation;
    waybar.enable = wmEnable && isLinux && isWorkstation;
    rofi.enable = wmEnable && isLinux && isWorkstation;
    swaync.enable = wmEnable && isLinux && isWorkstation;

    btop.enable = true;
    eza.enable = true;
    git.enable = true;
    fzf.enable = true;
    htop.enable = true;
    ripgrep.enable = true;
    lazygit.enable = true;
    neofetch.enable = true;
    fastfetch.enable = true;
    nvim.enable = true;
    helix.enable = true;
    password-store.enable = true;
    zsh.enable = true;
    fish.enable = true;
    zoxide.enable = true;
    yazi.enable = true;

    user = {
      impermanence.enable = isLinux && isWorkstation;
      ssh.enable = isLinux && isWorkstation;
      xdg.enable = isLinux && isWorkstation;

      packages.enable = true;
      variables.enable = true;
    };
  };
}
