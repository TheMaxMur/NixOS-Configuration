{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib) zipAttrs;
  inherit (lib.types) attrs listOf;

  cfg = config.module.services.ssh;
in {
  options.module.services.ssh = {
    enable = mkEnableOption "Enable module";

    listenAddresses = lib.mkOption {
      type = listOf attrs;
      default = [
        {
          addr = "0.0.0.0";
          port = 2222;
        }
      ];
      description = ''
        Specifies on which ports and addreses the SSH daemon listens.
      '';
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts =
      [
        22
      ]
      ++ (zipAttrs cfg.listenAddresses).port;

    services.endlessh-go = {
      enable = true;
      port = 22;
    };

    services.openssh = {
      inherit (cfg) listenAddresses;

      enable = true;

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
