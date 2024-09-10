{ self
, ...
}:

{
  perSystem = _: {
    # For nix topology
    topology.modules = [
      ({ config, ... }:
      let
        inherit 
          (config.lib.topology)
          mkRouter
          mkDevice
          mkConnection;
      in {
        inherit (self) nixosConfigurations; 

        networks = {
          timeweb-private = {
            name = "Timeweb private";
            cidrv4 = "10.20.0.0/16";
          };

          wireguard-private = {
            name = "Wireguard private";
            cidrv4 = "10.200.100.0/24";
          };
        };

        nodes = {
          timeweb-router = mkRouter "Timeweb router" {
            info = "Timeweb internal router";
            interfaceGroups = [
              [ "eth1" ]
              [ "wan1" ]
            ];
              
            interfaces = {
              eth1 = {
                addresses = [ "10.20.0.1" ];
                network = "timeweb-private";
              };
            };

            connections = {
              eth1 = [
                (mkConnection "site" "eth0")
                (mkConnection "services" "eth0")
              ];
            };
          };

          site = mkDevice "site" {
            deviceType = "device";
            hardware.info = "Site hosting";
            deviceIcon = ../images/timeweb.png;

            interfaces = {
              eth0 = {
                addresses = [ "10.20.0.4" ];
                network = "timeweb-private";
              };

              wg0 = {
                addresses = [ "10.200.100.1" ];
                network = "wireguard-private";
                renderer.hidePhysicalConnections = false;
                virtual = true;
                type = "wireguard";
              };
            };

            interfaceGroups = [
              [ "eth0" ]
              [ "wg0" ]
            ];

            services = {
              nginx = {
                name = "NGINX";
                icon = "services.nginx";
                details = {
                  "http" = { text = "0.0.0.0:80"; };
                  "https" = { text = "0.0.0.0:443"; };
                };
              };
            };
          };

          services = mkDevice "services" {
            deviceType = "device";
            hardware.info = "Services hosting";
            deviceIcon = ../images/timeweb.png;

            interfaces = {
              eth0 = {
                addresses = [ "10.20.0.5" ];
                network = "timeweb-private";
              };
            };

            interfaceGroups = [
              [ "eth0" ]
            ];

            services = {
              nginx = {
                name = "NGINX";
                icon = "services.nginx";
                details = {
                  "http" = { text = "0.0.0.0:80"; };
                  "https" = { text = "0.0.0.0:443"; };
                };
              };

              gitlab = {
                name = "Gitlab";
                icon = ../images/services/gitlab.png;
                details = {
                  "ssh" = { text = "0.0.0.0:4224"; };
                };
              };
            };
          };
        };
      })
    ];
  };
}

