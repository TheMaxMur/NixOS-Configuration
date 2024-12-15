{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.timedate;
in {
  options = {
    module.timedate.enable = mkEnableOption "Enables timedate";
  };

  config = mkIf cfg.enable {
    # Time settings
    time.timeZone = "Europe/Moscow";
    services.chrony.enable = true;
  };
}

