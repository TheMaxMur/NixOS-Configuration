{config, ...}: {
  module = {
    sound.enable = true;
    boot.enable = true;
    bluetooth.enable = true;
    locales.enable = true;
    network.enable = true;
    timedate.enable = true;
    users.enable = true;
    variables.enable = true;
    virtualisation.enable = true;
    stylix.enable = true;
    minimal.enable = true;
    nixos-ng.enable = true;
    plymouth.enable = true;
    binfmt.enable = true;
    xdg.enable = true;

    security = {
      enable = true;
      enableBootOptions = true;
    };

    services = {
      bolt.enable = true;
      fwupd.enable = true;
      polkit.enable = true;
      printing.enable = true;
      syncthing.enable = true;
      udev.enable = true;
      greetd.enable = true;
      qmk.enable = true;
      netbird.enable = true;
      yggdrasil.enable = true;
      zram.enable = true;
      irqbalance.enable = true;

      scx = {
        enable = true;
        schedulerType = "scx_bpfland";
      };

      ollama = {
        enable = true;
        gpuSupport.enable = config.services.ollama.enable;
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
