{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.variables;
in {
  options = {
    module.variables.enable = mkEnableOption "Enables variables";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };

    environment.sessionVariables = {
      FLAKE = "/home/${username}/Code/nixos-configuration";
    };
  };
}
