{ config
, lib
, ...
}:

with lib;

let
  cfg = config.module.services.ssh;
in {
  options.module.services.ssh = {
    enable = mkEnableOption "Enable module";

    listenAddresses = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ { addr = "0.0.0.0"; port = 2222; } ];
      description = ''
        Specifies on which ports and addreses the SSH daemon listens.
      '';
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      22
    ] ++ (lib.zipAttrs cfg.listenAddresses).port;

    services.endlessh-go = {
      enable = true;
      port = 22;
    };

    services.openssh = {
      inherit (cfg) listenAddresses;
      enable = true;

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      }; 
    };
  };
}

