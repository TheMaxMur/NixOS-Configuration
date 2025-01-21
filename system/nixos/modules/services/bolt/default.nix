{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.services.bolt;
in
{
  options = {
    module.services.bolt.enable = mkEnableOption "Enable bolt";
  };

  config = mkIf cfg.enable {
    services.hardware.bolt.enable = true;
  };
}
