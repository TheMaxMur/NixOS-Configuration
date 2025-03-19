{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str oneOf path;

  cfg = config.module.services.netbird-server;
in {
  options = {
    module.services.netbird-server = {
      enable = mkEnableOption "Enables netbird-server";

      domain = mkOption {
        type = str;
        default = "netbird.example.com";
        description = "Netbird domain name";
      };

      clientID = mkOption {
        type = str;
        default = "netbird";
        description = "Name of netbird client from keycloak";
      };

      backendID = mkOption {
        type = str;
        default = "netbird";
        description = "Name of netbird backend client for keycloak";
      };

      keycloakDomain = mkOption {
        type = str;
        default = "auth.example.com";
        description = "Keycloak domain name";
      };

      keycloakURL = mkOption {
        type = str;
        default = "https://auth.example.com/auth";
        description = "Path to root keycloak";
      };

      keycloakRealmName = mkOption {
        type = str;
        default = "example";
        description = "Name of keycloak realm";
      };

      coturnPasswordPath = mkOption {
        type = oneOf [str path];
        default = "/run/secrets/netbird/coturnPassword";
        description = "Path to coturn password file";
      };

      coturnSalt = mkOption {
        type = oneOf [str path];
        default = "/run/secrets/netbird/coturnPassword";
        description = "Path to coturn password file";
      };

      dataStoreEncryptionKeyPath = mkOption {
        type = oneOf [str path];
        default = "/run/secrets/netbird/DataStoreEncryptionKeyPath";
        description = "Path to datastore enc key file";
      };

      clientSecretPath = mkOption {
        type = oneOf [str path];
        default = "/run/secrets/netbird/clientSecret";
        description = "Path to client secret file for netbird backend";
      };
    };
  };

  config = mkIf cfg.enable {
    services.netbird.server = {
      inherit (cfg) domain;

      enable = true;
      enableNginx = true;

      coturn = {
        enable = true;
        passwordFile = cfg.coturnPasswordPath;
      };

      dashboard = {
        settings = {
          AUTH_AUTHORITY = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}";
          AUTH_AUDIENCE = cfg.clientID;
          AUTH_CLIENT_ID = cfg.clientID;
          AUTH_SUPPORTED_SCOPES = "openid profile email offline_access api";
          USE_AUTH0 = false;
        };
      };

      management = {
        oidcConfigEndpoint = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}/.well-known/openid-configuration";

        settings = {
          DataStoreEncryptionKey._secret = cfg.dataStoreEncryptionKeyPath;

          TURNConfig = {
            Secret._secret = cfg.coturnSalt;

            Turns = [
              {
                Proto = "udp";
                URI = "turn:${cfg.domain}:3478";
                Username = "netbird";
                Password._secret = cfg.coturnPasswordPath;
              }
            ];
          };

          HttpConfig = {
            AuthAudience = cfg.clientID;
            AuthIssuer = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}";
            AuthKeysLocation = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}/openid-connect/certs";
            IdpSignKeyRefreshEnabled = false;
          };

          IdpManagerConfig = {
            ManagerType = "keycloak";

            ClientConfig = {
              Issuer = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}";
              TokenEndpoint = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}/protocol/openid-connect/token";
              ClientID = cfg.backendID;
              ClientSecret._secret = cfg.clientSecretPath;
            };

            ExtraConfig = {
              AdminEndpoint = "${cfg.keycloakURL}/admin/realms/${cfg.keycloakRealmName}";
            };
          };

          DeviceAuthorizationFlow = {
            Provider = "hosted";

            ProviderConfig = {
              ClientID = cfg.clientID;
              Audience = cfg.clientID;
              Domain = cfg.keycloakDomain;
              TokenEndpoint = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}/protocol/openid-connect/token";
              DeviceAuthEndpoint = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}/protocol/openid-connect/auth/device";
              Scope = "openid";
              UseIDToken = false;
            };
          };

          PKCEAuthorizationFlow = {
            ProviderConfig = {
              ClientID = cfg.clientID;
              Audience = cfg.clientID;
              TokenEndpoint = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}/protocol/openid-connect/token";
              AuthorizationEndpoint = "${cfg.keycloakURL}/realms/${cfg.keycloakRealmName}/protocol/openid-connect/auth";
            };
          };
        };
      };
    };
  };
}
