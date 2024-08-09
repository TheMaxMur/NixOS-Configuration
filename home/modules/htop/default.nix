{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.htop;
in {
  options = {
    module.htop.enable = mkEnableOption "Enables htop";
  };

  config = mkIf cfg.enable {
    programs.htop = {
      enable = true;
    };
  };
}

