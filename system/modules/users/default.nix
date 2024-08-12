{ self
, pkgs
, lib
, config
, username
, ...
}:

with lib;

let
  cfg = config.module.users;
in {
  options = {
    module.users.enable = mkEnableOption "Enables users";
  };

  config = mkIf cfg.enable {
    users = {
      mutableUsers = false;

      users = {
        ${username} = {
          isNormalUser = true;
          description = "${username}";
          home = "/home/${username}";
          shell = pkgs.fish;
          hashedPasswordFile = "${self}/secrets/hashes/${username}.hash";

          extraGroups = [
            "audio"
            "networkmanager"
            "wheel"
            "docker"
            "libvirtd"
          ];
        };

        root = {
          shell = pkgs.zsh;
          hashedPasswordFile = "${self}/secrets/hashes/root.hash";
        };
      };
    };
  };
}

