{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.virtualisation;
in {
  options = {
    module.virtualisation.enable = mkEnableOption "Enables virtualisation";
  };

  config = mkIf cfg.enable {
    # Virtualization settings
    users.extraGroups.vboxusers.members = [ "maxmur" ];

    virtualisation = {
      docker.enable = true;
      libvirtd.enable = true;
      # virtualbox.host.enable = true;
    };
  };
}

