{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.minimal;
in {
  options = {
    module.minimal = {
      enable = mkEnableOption "Enables minimal";
    };
  };

  config = mkIf cfg.enable {
    # Disable dodocumentation
    documentation.enable = mkDefault false;
    documentation.doc.enable = mkDefault false;
    documentation.info.enable = mkDefault false;
    documentation.man.enable = mkDefault false;
    documentation.nixos.enable = mkDefault false;

    services.logrotate.enable = mkDefault false;
  };
}

