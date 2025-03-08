{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.programs.hm;
in {
  options = {
    module.programs.hm.enable = mkEnableOption "Enable Home Manager";
  };

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}
