{ inputs
, ...
}:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
    ../../modules/stylix

    ./alacritty
    ./chrome
    ./firefox
    ./flameshot
    ./foot
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
  ];
}

