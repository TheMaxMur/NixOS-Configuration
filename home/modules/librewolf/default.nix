{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.librewolf;
in {
  options = {
    module.librewolf.enable = mkEnableOption "Enables librewolf";
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;

      profiles = {
        work = {
          id = 1;
          name = "Work";

          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            vimium
            bitwarden
          ];

          search = {
            force = true;
            default = "Google";

            order = [
              "Google"
              "DuckDuckGo"
            ];

            engines = {
              "Bing".metaData.hidden = true;
              "Amazon.com".metaData.hidden = true;
            };
          };
        };

        default = {
          id = 0;
          name = "Default";
          isDefault = true;

          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            sponsorblock
            return-youtube-dislikes
            foxyproxy-standard
            vimium
            wappalyzer
            bitwarden
          ];

          search = {
            force = true;
            default = "Kagi";

            order = [
              "Kagi"
              "Google"
              "DuckDuckGo"
              "4get"
              "nogoo"
              "Youtube"
              "NixOS Options"
              "Nix Packages"
              "GitHub"
              "Home Manager"
            ];

            engines = {
              "Bing".metaData.hidden = true;
              "Amazon.com".metaData.hidden = true;

              "Kagi" = {
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@kagi"];
                urls = [
                  {
                    template = "https://kagi.com/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "4get" = {
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@4get"];
                urls = [
                  {
                    template = "https://4get.bloat.cat/web";
                    params = [
                      {
                        name = "s";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "nogoo" = {
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@nogoo"];
                urls = [
                  {
                    template = "https://nogoo.me/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "YouTube" = {
                iconUpdateURL = "https://youtube.com/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@yt"];
                urls = [
                  {
                    template = "https://www.youtube.com/results";
                    params = [
                      {
                        name = "search_query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "Nix Packages" = {
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@np"];
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "NixOS Options" = {
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@no"];
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "GitHub" = {
                iconUpdateURL = "https://github.com/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@gh"];

                urls = [
                  {
                    template = "https://github.com/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "Home Manager" = {
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@hm"];

                url = [
                  {
                    template = "https://mipmip.github.io/home-manager-option-search/";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };
            };
          };
        };
      };

      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "network.cookie.lifetimePolicy" = 0;

        "browser.fullscreen.autohide" = false;
        "ui.key.menuAccessKeyFocuses" = false;

        "browser.translations.enable" = false;
        "geo.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "gfx.webrender.all" = true;
        "gfx.webrender.compositor" = true;
        "image.jxl.enabled" = true;

        # Disable some useless stuff
        "extensions.pocket.enabled" = false; # disable pocket, save links, send tabs
        "extensions.abuseReport.enabled" = false; # don't show 'report abuse' in extensions
        "extensions.formautofill.creditCards.enabled" = false; # don't auto-fill credit card information
        "identity.fxaccounts.enabled" = false; # disable firefox login
        "identity.fxaccounts.toolbar.enabled" = false;
        "identity.fxaccounts.pairing.enabled" = false;
        "identity.fxaccounts.commands.enabled" = false;
        "browser.contentblocking.report.lockwise.enabled" = false; # don't use firefox password manger
        "browser.uitour.enabled" = false; # no tutorial please
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # Disable telemetry for privacy reasons
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.enabled" = false; # enforced by nixos
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.unified" = false;
        "extensions.webcompat-reporter.enabled" = false; # don't report compability problems to mozilla
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.urlbar.eventTelemetry.enabled" = false; # (default)

        # disable annoying web features
        "dom.push.enabled" = false; # no notifications, really...
        "dom.push.connection.enabled" = false;
        "dom.battery.enabled" = false; # you don't need to see my battery...

        "extensions.autoDisableScopes" = 0;
        "extensions.enabledScopes" = 15;
        "browser.bookmarks.addedImportButton" = false;
        "browser.toolbars.bookmarks.visibility" = "never";

        "network.dns.echconfig.enabled" = false;
        "network.dns.http3_echconfig.enabled" = false;
      };
    };
  };
}
