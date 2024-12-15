{ lib 
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.services.netbird;
in {
  options = {
    module.services.netbird = {
      enable = mkEnableOption "Enables netbird";
    };
  };

  config = mkIf cfg.enable {
    services.netbird.enable = true;
    environment.systemPackages = [ pkgs.netbird-ui ];
  };
}

