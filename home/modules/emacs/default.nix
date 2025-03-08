{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.emacs;
in {
  options = {
    module.emacs.enable = mkEnableOption "Enable emacs";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs30-pgtk;
    };

    services.emacs = {
      inherit (config.programs.emacs) package enable;

      client.enable = true;
      socketActivation.enable = true;
    };
  };
}
