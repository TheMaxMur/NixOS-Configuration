{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.btop;
in {
  options = {
    module.btop.enable = mkEnableOption "Enables btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
    };
  };
}

