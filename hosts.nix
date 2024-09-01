{
  nixos = {
    pcbox = {
      hostname      = "pcbox";
      username      = "maxmur";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "sway";
    };

    nbox = {
      hostname      = "nbox";
      username      = "maxmur";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "sway";
    };

    rasp = {
      hostname      = "rasp";
      username      = "maxmur";
      platform      = "aarch64-linux";
      stateVersion  = "24.11";
      isWorkstation = false;
    };
  };

  darwin = {
    macbox = {
      hostname      = "macbox";
      username      = "maxmur";
      platform      = "aarch64-darwin";
      stateVersion  = 6;
      isWorkstation = true;
    };
  };
}

