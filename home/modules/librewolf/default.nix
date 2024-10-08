{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.librewolf;
in {
  options = {
    module.librewolf.enable = mkEnableOption "Enables librewolf";
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;

      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "network.cookie.lifetimePolicy" = 0;

        "browser.fullscreen.autohide" = false;
      };
    };
  };
}

