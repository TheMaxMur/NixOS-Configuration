{
  nixos = {
    pcbox = {
      username      = "maxmur";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "sway";
    };

    nbox = {
      username      = "maxmur";
      platform      = "x86_64-linux";
      stateVersion  = "24.11";
      isWorkstation = true;
      wm            = "sway";
    };

    rasp = {
      username      = "maxmur";
      platform      = "aarch64-linux";
      stateVersion  = "24.11";
      isWorkstation = false;
    };
  };

  darwin = {
    macbox = {
      username      = "maxmur";
      platform      = "aarch64-darwin";
      stateVersion  = 6;
      isWorkstation = true;
    };
  };
}

