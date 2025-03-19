{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str;
in {
  options.module.defaults = {
    notificationsAppCmd = mkOption {
      type = str;
      default = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
    };
  };
}
