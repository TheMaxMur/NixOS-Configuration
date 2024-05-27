{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.security;
in {
  options = {
    module.security.enable = mkEnableOption "Enables security";
  };

  config = mkIf cfg.enable {
    # environment.memoryAllocator.provider = "scudo";

    security = {
      sudo.enable = true;
      # lockKernelModules = true;
      # protectKernelImage = true;
      # forcePageTableIsolation = true;
      pam.services.swaylock = {};

      doas = {
        enable = true;
        extraRules = [
          {
            groups = [ "wheel" ];
            noPass = false;
            keepEnv = true;
            persist = true;
          }
        ];
      };
    };
  };
}

