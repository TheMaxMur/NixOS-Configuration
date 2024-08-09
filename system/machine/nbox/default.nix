{ self
, hostModules

, hostname
, ...
}:

let
  machineModules = "${self}/system/machine/${hostname}/modules";
in {
  imports = [
    "${hostModules}"
    "${machineModules}"
  ];

  programs.command-not-found.enable = true;

  module = {
    locales.enable                 = true;
    network.enable                 = true;
    security.enable                = true;
    timedate.enable                = true;
    users.enable                   = true;
    variables.enable               = true;
    virtualisation.enable          = true;

    services = {
      bolt.enable         = true;
      cpu-autofreq.enable = true;
      fwupd.enable        = true;
      polkit.enable       = true;
      printing.enable     = true;
      syncthing.enable    = true;
      udev.enable         = true;
      zram.enable         = true;
      greetd-tui.enable   = true;
      hyprland.enable     = true;
    };

    programs = {
      dconf.enable      = true;
      gnupg.enable      = true;
      hm.enable         = true;
      nh.enable         = true;
      kdeconnect.enable = true;
      mtr.enable        = true;
      xdg-portal.enable = true;
      zsh.enable        = true;
      fish.enable       = true;
      systemPackages.enable = true;
    };
  };
}

