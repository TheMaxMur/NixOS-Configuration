{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.firefox;
in {
  options = {
    module.firefox.enable = mkEnableOption "Enables firefox";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}

