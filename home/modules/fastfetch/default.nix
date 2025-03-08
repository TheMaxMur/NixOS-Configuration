{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.fastfetch;
in {
  options = {
    module.fastfetch = {
      enable = mkEnableOption "Enable fastfetch";
    };
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo = {
          type = "builtin";
          source = "NixOS";
        };

        display = {
          color = {
            keys = "blue";
            title = "blue";
          };
        };

        modules = [
          "title"
          "separator"
          {
            type = "os";
            key = "Distro";
            format = "{3}";
          }
          {
            type = "kernel";
            key = "Kernel Version";
            format = "{2}";
          }
          {
            type = "packages";
            format = "{9}";
          }
          "shell"
          "wm"
          "separator"
          {
            type = "cpu";
            format = "{1} - {3} Cores";
          }
          {
            type = "gpu";
            key = "GPU";
            hideType = "integrated";
            format = "{2}";
          }
          {
            type = "memory";
          }
          {
            type = "disk";
          }
        ];
      };
    };
  };
}
