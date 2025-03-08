{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.thunderbird;
in {
  options = {
    module.thunderbird.enable = mkEnableOption "Enables thunderbird";
  };

  config = mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;

      profiles = {
        "main" = {
          isDefault = true;

          settings = {
            "calendar.alarms.showmissed" = false;
            "calendar.alarms.playsound" = false;
            "calendar.alarms.show" = false;
          };
        };
      };
    };
  };
}
