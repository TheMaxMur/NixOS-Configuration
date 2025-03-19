{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str;

  cfg = config.module.services.privatebin;
in {
  options = {
    module.services.privatebin = {
      enable = mkEnableOption "Enable privatebin";

      domain = mkOption {
        type = str;
        default = "paste.example.com";
        description = "PrivateBin domain";
      };

      name = mkOption {
        type = str;
        default = "PrivateBin";
        description = "PrivateBin site name";
      };
    };
  };

  config = mkIf cfg.enable {
    services.privatebin = {
      enable = true;
      enableNginx = true;
      virtualHost = cfg.domain;

      settings = {
        main = {
          inherit (cfg) name;

          compression = "none";
          defaultformatter = "plaintext";
          discussion = false;
          email = true;
          fileupload = false;
          languageselection = false;
          password = true;
          qrcode = true;
          sizelimit = 10 * 1000 * 1000;
          template = "bootstrap";
        };

        expire = {
          default = "1week";
        };

        formatter_options = {
          markdown = "Markdown";
          plaintext = "Plain Text";
          syntaxhighlighting = "Source Code";
        };

        traffic = {
          limit = 10;
        };

        purge = {
          limit = 0;
          batchsize = 10;
        };
      };
    };
  };
}
