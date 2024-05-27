{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.htop;
in {
  options = {
    module.htop.enable = mkEnableOption "Enables htop";
  };

  config = mkIf cfg.enable {
    # home.file.".config/htop/htoprc".source = ./htoprc;

    programs.htop = {
      enable = true;
    };
  };
}

