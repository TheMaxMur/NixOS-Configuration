{
  nixos = {
    pcbox = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = true;
      wm = "sway";
      theme = "nord";
    };

    nbox = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = true;
      wm = "sway";
      theme = "nord";
    };

    rasp = {
      username = "maxmur";
      platform = "aarch64-linux";
      stateVersion = "25.05";
      isWorkstation = false;
      theme = "nord";
    };

    hlbox = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "24.11";
      isWorkstation = false;
      theme = "nord";
    };

    p8box = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "25.05";
      isWorkstation = true;
      wm = "sway";
      theme = "nord";
    };

    dnsvm = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "24.11";
      isWorkstation = false;
      theme = "nord";
    };

    dbvm = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "24.11";
      isWorkstation = false;
      theme = "nord";
    };

    gitvm = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "24.11";
      isWorkstation = false;
      theme = "nord";
    };

    vaultvm = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "24.11";
      isWorkstation = false;
      theme = "nord";
    };

    vpntwvm = {
      username = "maxmur";
      platform = "x86_64-linux";
      stateVersion = "24.11";
      isWorkstation = false;
      theme = "nord";
    };
  };

  darwin = {
    macbox = {
      username = "maxmur";
      platform = "aarch64-darwin";
      stateVersion = 5;
      isWorkstation = true;
      theme = "nord";
    };
  };
}
