{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str;
in {
  options.module.defaults = {
    brightnessControlCmd = mkOption {
      type = str;
      default = "${pkgs.brightnessctl}/bin/brightnessctl";
    };
  };
}
