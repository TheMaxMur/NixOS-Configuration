{ inputs
, pkgs
, ...
}: 

{
  environment.systemPackages = with pkgs; [ 
    vim
    neovim
    home-manager
    nerdfonts
    alacritty
  ];

  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  programs.zsh.enable = true;
  # programs.fish.enable = true;

  system.configurationRevision = inputs.rev or inputs.dirtyRev or null;
}

