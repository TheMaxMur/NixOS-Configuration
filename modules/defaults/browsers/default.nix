{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum str;

  cfg = config.module.defaults;
in {
  options.module.defaults = {
    browser = mkOption {
      type = enum [
        "librewolf"
        "firefox"
        "chromium"
      ];

      default = "librewolf";
    };

    browserCmd = let
      browserExecs = {
        librewolf = "${pkgs.librewolf}/bin/librewolf";
        firefox = "${pkgs.firefox}/bin/firefox";
        chromium = "${pkgs.ungoogled-chromium}/bin/chromium";
      };
    in
      mkOption {
        type = str;
        default = browserExecs.${cfg.browser};
      };
  };
}
