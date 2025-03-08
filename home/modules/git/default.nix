{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.git;
in {
  options = {
    module.git.enable = mkEnableOption "Enables git";
  };

  config = mkIf cfg.enable {
    # Git config
    programs.git = {
      enable = true;
      userName = "TheMaxMur";
      userEmail = "muravjev.mak@yandex.ru";

      signing = {
        key = "EC9C10ED7A62D7BDB796B05EEB757CE80A4B2F30";
        signByDefault = true;
      };

      includes = [
        {
          path = "~/Code/work/gitconfig";
          condition = "gitdir:~/Code/work/**";
        }
      ];
    };
  };
}
