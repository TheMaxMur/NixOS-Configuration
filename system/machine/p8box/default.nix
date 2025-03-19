_: {
  module = {
    sound.enable = true;
    boot.enable = true;
    locales.enable = true;
    network.enable = true;
    timedate.enable = true;
    users.enable = true;
    variables.enable = true;
    stylix.enable = true;
    minimal.enable = true;
    nixos-ng.enable = true;
    plymouth.enable = true;
    xdg.enable = true;

    security = {
      enable = true;
      enableBootOptions = true;
    };

    services = {
      tlp.enable = true;
      fwupd.enable = true;
      polkit.enable = true;
      printing.enable = true;
      syncthing.enable = true;
      udev.enable = true;
      zram.enable = true;
      greetd.enable = true;
      netbird.enable = true;
      irqbalance.enable = true;

      scx = {
        enable = true;
        schedulerType = "scx_bpfland";
      };
    };

    programs = {
      dconf.enable = true;
      gnupg.enable = true;
      hm.enable = true;
      nh.enable = true;
      kdeconnect.enable = true;
      mtr.enable = true;
      xdg-portal.enable = true;
      zsh.enable = true;
      fish.enable = true;
      systemPackages.enable = true;
    };
  };
}
