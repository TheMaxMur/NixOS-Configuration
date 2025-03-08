{
  inputs,
  pkgs,
  username,
  ...
}: {
  module = {
    stylix = {
      enable = true;
      useCursor = false;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    home-manager
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.iosevka
    alacritty
  ];

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    description = username;
  };

  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  programs.zsh.enable = true;
  # programs.fish.enable = true;

  system.configurationRevision = inputs.rev or inputs.dirtyRev or null;
}
