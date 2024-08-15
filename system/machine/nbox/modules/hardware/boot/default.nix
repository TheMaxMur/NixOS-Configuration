{ inputs
, lib
, ...
}:

{
  # Bootloader settings
  imports = [
   inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot = {
    loader.systemd-boot.enable = lib.mkForce false;
    loader.efi.canTouchEfiVariables = true;

    lanzaboote = {
     enable = true;
     pkiBundle = "/etc/secureboot";
    };
  };
}

