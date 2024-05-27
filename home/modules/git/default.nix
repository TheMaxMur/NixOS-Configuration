{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.git;
in {
  options = {
    module.git.enable = mkEnableOption "Enables git";
  };

  config = mkIf cfg.enable {
    # Git config
    programs.git = {
      enable = true;
      userName = "maxmur";
      userEmail = "muravjev.mak@yandex.ru";
    };
  };
}

