{
  inputs,
  pkgs,
  ...
}: {
  home = {
    homeDirectory = "/home/test";

    # Software
    packages = with pkgs; [
      # Browsers
      firefox

      # Menu
      ulauncher
    ];
  };

  imports = [
    inputs.yandex-music.nixosModule

    ../../../../modules/nixConfig
    ../../../modules/alacritty
    ../../../modules/flameshot
    ../../../modules/cinnamon
    ../../../modules/neofetch
    ../../../modules/chrome
    ../../../modules/htop
    ../../../modules/zsh
    ../../../modules/git
  ];
}
