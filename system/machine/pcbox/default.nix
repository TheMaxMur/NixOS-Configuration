{ inputs
, ...
}:

{
  imports = [
    ../../modules
    ./modules/hardware
    # inputs.hyprland.nixosModules.default
  ];

  # home-manager.sharedModules = [inputs.hyprland.homeManagerModules.default];

  module = {
    locales.enable = true;
    network.enable = true;
    security.enable = true;
    timedate.enable = true;
    users.enable = true;
    variables.enable = true;
    virtualisation.enable = true;
    programs.systemPackages.enable = true;

    services = {
      bolt.enable = true;
      fwupd.enable = true;
      polkit.enable = true;
      printing.enable = true;
      syncthing.enable = true;
      udev.enable = true;
      greetd-tui.enable = true;
    };
  };
}

