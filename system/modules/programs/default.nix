{ lib
, ...
}:

with lib;

{
  imports = [
    ./systemPackages
    ./home-manager
    ./nix-helper
    ./kdeconnect
    ./xdg-portal
    ./gnupg
    ./zsh
    ./mtr
    ./dconf
  ];

  module.programs = {
    dconf.enable      = mkDefault true;
    gnupg.enable      = mkDefault true;
    hm.enable         = mkDefault true;
    nh.enable         = mkDefault true;
    kdeconnect.enable = mkDefault true;
    mtr.enable        = mkDefault true;
    xdg-portal.enable = mkDefault true;
    zsh.enable        = mkDefault true;
  };
}

