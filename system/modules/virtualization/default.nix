{ lib
, config
, pkgs
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
    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    users.extraGroups.vboxusers.members = [ "maxmur" ];

    virtualisation = {
      docker.enable = true;
      podman.enable = true;
      libvirtd.enable = true;
      # virtualbox.host.enable = true;
    };
  };
}

