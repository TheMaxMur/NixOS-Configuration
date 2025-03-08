{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.boot;
in {
  options = {
    module.boot = {
      enable = mkEnableOption "Enables Bootloader";
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
