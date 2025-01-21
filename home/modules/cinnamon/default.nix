{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.cinnamon;
in
{
  imports = [
    #    ./dconf2nix.nix
  ];

  options = {
    module.cinnamon.enable = mkEnableOption "Enables Cinnamon configuration";
  };

  config = mkIf cfg.enable {
    dconf.enable = true;
  };
}
