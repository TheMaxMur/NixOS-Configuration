{
  lib,
  config,
  username,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.virtualisation;
in {
  options = {
    module.virtualisation = {
      enable = mkEnableOption "Enables virtualisation";
    };
  };

  config = mkIf cfg.enable {
    # Virtualization settings
    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    users.extraGroups.vboxusers.members = [username];

    virtualisation = {
      docker.enable = true;
      podman.enable = true;
      libvirtd.enable = true;
      virtualbox.host.enable = true;
    };
  };
}
