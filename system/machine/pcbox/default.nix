{ hyprlandEnable
, config
, ...
}:

{
  module = {
    locales.enable        = true;
    network.enable        = true;
    security.enable       = true;
    timedate.enable       = true;
    users.enable          = true;
    variables.enable      = true;
    virtualisation.enable = true;

    services = {
      bolt.enable              = true;
      fwupd.enable             = true;
      polkit.enable            = true;
      printing.enable          = true;
      syncthing.enable         = true;
      udev.enable              = true;
      greetd-tui.enable        = true;
      qmk.enable               = true;

      hyprland.enable = hyprlandEnable;

      ollama = {
        enable            = true;
        gpuSupport.enable = config.services.ollama.enable;
      };
    };

    programs = {
      dconf.enable          = true;
      gnupg.enable          = true;
      hm.enable             = true;
      nh.enable             = true;
      kdeconnect.enable     = true;
      mtr.enable            = true;
      xdg-portal.enable     = true;
      zsh.enable            = true;
      fish.enable           = true;
      systemPackages.enable = true;
    };
  };
}

