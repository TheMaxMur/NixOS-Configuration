{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.adguard-home;
in {
  options = {
    module.services.adguard-home = {
      enable = mkEnableOption "Enables adguard-home";
    };
  };

  config = mkIf cfg.enable {
    services.adguardhome = {
      enable = true;
      mutableSettings = true;
    };
  };
}

