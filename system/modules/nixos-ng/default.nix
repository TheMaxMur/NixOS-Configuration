{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.nixos-ng;
in {
  options = {
    module.nixos-ng = {
      enable = mkEnableOption "Enables nixos-ng";
    };
  };

  config = mkIf cfg.enable {
    boot.initrd.systemd.enable = true;
    # systemd.sysusers.enable = true; ### break

    system.switch = {
      enable = false;
      enableNg = true;
    };

    # system.etc.overlay = {
      # enable = true;
      # mutable = false;
    # };
  };
}

