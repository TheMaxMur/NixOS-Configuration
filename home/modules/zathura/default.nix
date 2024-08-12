{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.zathura;
in {
  options = {
    module.zathura.enable = mkEnableOption "Enables zathura";
  };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
    };
  };
}

