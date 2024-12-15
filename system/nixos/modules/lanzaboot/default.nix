{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.lanzaboote;
in {
  options = {
    module.lanzaboote = {
      enable = mkEnableOption "Enables lanzaboote";
    };
  };

  config = mkIf cfg.enable {
    # Bootloader settings
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      loader.efi.canTouchEfiVariables = true;

      lanzaboote = {
       enable = true;
       pkiBundle = "/etc/secureboot";
      };
    };
  };
}

