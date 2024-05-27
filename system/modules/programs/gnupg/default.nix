{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.programs.gnupg;
in {
  options = {
    module.programs.gnupg.enable = mkEnableOption "Enables GnuPG";
  };

  config = mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryPackage = lib.mkForce pkgs.pinentry-qt;
    };
  };
}

