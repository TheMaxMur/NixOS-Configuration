{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.programs.nh;
in {
  options = {
    module.programs.nh.enable = mkEnableOption "Enable Nix Helper";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = "/home/${username}/Code/nixos-configuration";

      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
    };
  };
}
