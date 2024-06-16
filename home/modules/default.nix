{ inputs
, ...
}:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
    ../../modules/stylix

    ./alacritty
    ./chrome
    ./eza
    ./firefox
    ./flameshot
    ./foot
    ./fish
    ./fzf
    ./git
    ./helix
    ./htop
    ./neofetch
    ./neovim
    ./password-store
    ./ripgrep
    ./vscode
    ./zsh
    ./hyprland
    ./waybar
    ./hyprlock
    ./hypridle
    ./rofi
    ./dconf
    ./xdg
    ./zathura
    ./zoxide
  ];
}

