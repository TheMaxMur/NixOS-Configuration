{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.scx;
in {
  options = {
    module.services.scx = {
      enable = mkEnableOption "Enables scx module"; 

      schedulerType = mkOption {
        type = types.str;
        default = "scx_rustland";
      };
    };
  };

  config = mkIf cfg.enable {
    services.scx = {
      enable = true;
      scheduler = cfg.schedulerType;
    };
  };
}

