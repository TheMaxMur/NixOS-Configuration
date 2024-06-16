{ lib
, ...
}:

with lib;

{
  imports = [
    ./cpu-autofreq
    ./greetd-tui
    ./syncthing
    ./hyprland
    ./printing
    ./xserver
    ./polkit
    ./fwupd
    ./udev
    ./bolt
    ./zram
    ./tlp
  ];

  /*
  module.services = {
    bolt.enable = mkDefault true;
    cpu-autofreq.enable = mkDefault true;
    fwupd.enable = mkDefault true;
    polkit.enable = mkDefault true;
    printing.enable = mkDefault true;
    syncthing.enable = mkDefault true;
    tlp.enable = mkDefault true;
    udev.enable = mkDefault true;
    xserver.enable = mkDefault true;
    zram.enable = mkDefault true;
  };
  */
}

