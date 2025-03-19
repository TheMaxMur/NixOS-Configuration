{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) str;
in {
  options.module.defaults = {
    network = {
      iface = mkOption {
        type = str;
        default = "";
      };

      ip = mkOption {
        type = str;
        default = "";
      };

      gw = mkOption {
        type = str;
        default = "";
      };

      mask = mkOption {
        type = str;
        default = "";
      };

      cidr = mkOption {
        type = str;
        default = "";
      };

      mac = mkOption {
        type = str;
        default = "";
      };
    };
  };
}
