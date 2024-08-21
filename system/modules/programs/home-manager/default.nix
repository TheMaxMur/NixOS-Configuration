{ inputs
, lib
, config
, ...
}:

with lib;

let
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

