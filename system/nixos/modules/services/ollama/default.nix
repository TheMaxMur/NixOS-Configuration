{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

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
