{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.services.yggdrasil;
in {
  options.module.services.yggdrasil = {
    enable = mkEnableOption "Enable module yggdrasil";
  };

  config = mkIf cfg.enable {
    services.yggdrasil = {
      enable = true;
      persistentKeys = true;

      settings = {
        IfName = "ygg0";
        Peers = [
          "tls://188.225.9.167:18227"
          "tls://45.147.200.202:443"
          "tls://45.95.202.21:443"
        ];
      };
    };
  };
}
