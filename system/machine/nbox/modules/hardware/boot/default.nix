{ inputs
, ...
}:

{
  # Bootloader settings
  # imports = [
  #  inputs.lanzaboote.nixosModules.lanzaboote
  # ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # lanzaboote = {
    #  enable = true;
    #  pkiBundle = "/etc/secureboot";
    #};
  };
}

