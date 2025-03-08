{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.nixos-ng;
in {
  options = {
    module.nixos-ng = {
      enable = mkEnableOption "Enables nixos-ng";
    };
  };

  config = mkIf cfg.enable {
    boot.initrd.systemd.enable = true;

    services = {
      userborn.enable = true;
      dbus.implementation = "broker";
    };

    system = {
      switch = {
        enable = false;
        enableNg = true;
      };

      /*
      etc.overlay = {
        enable = true;
        mutable = true;
      };
      */
    };
  };
}
