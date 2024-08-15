{ homeModules
, ...
}:

{
  imports = [
    "${homeModules}/alacritty"
    "${homeModules}/btop"
    "${homeModules}/chrome"
    "${homeModules}/eza"
    "${homeModules}/doom-emacs"
    "${homeModules}/firefox"
    "${homeModules}/flameshot"
    "${homeModules}/foot"
    "${homeModules}/fish"
    "${homeModules}/fzf"
    "${homeModules}/git"
    "${homeModules}/helix"
    "${homeModules}/htop"
    "${homeModules}/neofetch"
    "${homeModules}/neovim"
    "${homeModules}/password-store"
    "${homeModules}/ripgrep"
    "${homeModules}/vscode"
    "${homeModules}/zsh"
    "${homeModules}/hyprland"
    "${homeModules}/hyprpaper"
    "${homeModules}/hyprlock"
    "${homeModules}/hypridle"
    "${homeModules}/impermanence"
    "${homeModules}/rofi"
    "${homeModules}/waybar"
    "${homeModules}/dconf"
    "${homeModules}/xdg"
    "${homeModules}/zathura"
    "${homeModules}/zoxide"
    "${homeModules}/yazi"
    "${homeModules}/swaync"
  ];
}

