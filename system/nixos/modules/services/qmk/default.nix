{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.qmk;
in {
  options = {
    module.services.qmk.enable = mkEnableOption "Enables qmk";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qmk
    ];

    services.udev.packages = with pkgs; [
      qmk-udev-rules
    ];

    hardware.keyboard.qmk.enable = true;
  };
}
