{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.programs.dconf;
in {
  options = {
    module.programs.dconf.enable = mkEnableOption "Enable dconf";
  };

  config = mkIf cfg.enable {
    programs.dconf.enable = true;
  };
}

