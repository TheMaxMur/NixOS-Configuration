{
  nixos = {
    pcbox = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = true;
      wm = "sway";
    };

    nbox = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = true;
      wm = "sway";
    };

    rasp = {
      username = "maxmur";
      platform = "aarch64-linux";
      stateVersion = "25.05";
      isWorkstation = false;
    };

    hlbox = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = false;
    };

    p8box = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = true;
      wm = "sway";
    };
  };

  darwin = {
    macbox = {
      username = "maxmur";
      platform = "aarch64-darwin";
      stateVersion = 5;
      isWorkstation = true;
    };
  };
}
