{config, ...}: {
  nix = {
    gc = {
      automatic = !config.programs.nh.enable;
      options = "--delete-older-than 14d";
    };
  };
}
