{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.chaotic;
in {
  options = {
    module.chaotic = {
      enable = mkEnableOption "Enables chaotic module"; 

      schedulerType = mkOption {
        type = types.str;
        default = "scx_rustland";
      };
    };
  };

  config = mkIf cfg.enable {
    chaotic.scx.enable = true;
    chaotic.scx.scheduler = cfg.schedulerType;
  };
}

