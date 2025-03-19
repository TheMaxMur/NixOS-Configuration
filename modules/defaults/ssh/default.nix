{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) str listOf;
in {
  options.module.defaults = {
    ssh = {
      pubKeys = mkOption {
        type = listOf str;
        default = [];
      };
    };
  };
}
