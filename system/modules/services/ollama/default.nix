{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.ollama;
in {
  options = {
    module.services.ollama.enable = mkEnableOption "Enables ollama";
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
    };
  };
}

