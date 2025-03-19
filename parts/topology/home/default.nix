{self, ...}: {
  perSystem = _: {
    # For nix topology
    topology.modules = [
      (
        {config, ...}: let
          inherit
            (config.lib.topology)
            mkRouter
            mkSwitch
            mkDevice
            mkConnection
            ;
        in {
          inherit (self) nixosConfigurations;

          networks = {
            mgts-bridge = {
              name = "MGTS bridge network";
              cidrv4 = "192.168.0.0/24";
            };

            home-maxmur = {
              name = "Home maxmur";
              cidrv4 = "192.168.1.0/24";
            };

            hlbox-nat = {
              name = "Microvm hlbox nat";
              cidrv4 = "10.0.0.0/24";
            };
          };

          nodes = {
            mgts-bridge-router = mkRouter "Bridge router" {
              info = "MGTS Innbox G84";
              image = ../images/Innbox_G84.png;

              interfaceGroups = [
                ["eth1"]
                ["wan1"]
              ];

              interfaces = {
                eth1 = {
                  addresses = ["192.168.0.1"];
                  network = "mgts-bridge";
                };
              };

              connections = {
                eth1 = mkConnection "main-router" "wan1";
              };
            };

            main-router = mkRouter "Main Router" {
              info = "Keenetic Giga";
              image = ../images/keenetic-giga.png;

              interfaceGroups = [
                [
                  "eth1"
                  "wifi"
                ]
                ["wan1"]
              ];

              interfaces = {
                eth1 = {
                  addresses = ["192.168.1.1"];
                  network = "home-maxmur";
                };

                wifi = {
                  addresses = ["192.168.1.1"];
                  network = "home-maxmur";
                };

                wan1 = {
                  addresses = ["192.168.0.2"];
                  network = "mgts-bridge";
                };
              };

              connections = {
                wifi = [
                  (mkConnection
                    "nbox"
                    "wlp3s0")
                  (mkConnection
                    "p8box"
                    "wlp3s0")
                ];
              };
            };

            switch-main = mkSwitch "Main Switch" {
              info = "TP-Link TL-SG1016D";
              image = ../images/TL-SG1016D.png;

              interfaceGroups = [
                [
                  "eth1"
                  "eth2"
                  "eth3"
                  "eth4"
                  "eth5"
                ]
              ];

              connections = {
                eth1 = mkConnection "main-router" "eth1";
                eth2 = mkConnection "pcbox" "eth0";
                eth3 = mkConnection "rasp" "eth0";
                eth4 = mkConnection "macbox" "eth0";
                eth5 = mkConnection "hlbox" "vmbr0";
              };
            };

            macbox = mkDevice "macbox" {
              deviceType = "device";
              hardware.info = "Mac Mini";
              deviceIcon = ../images/apple.png;

              interfaces = {
                eth0 = {
                  addresses = ["192.168.1.75"];
                  network = "home-maxmur";
                };
              };

              interfaceGroups = [
                ["eth0"]
              ];
            };
          };
        }
      )
    ];
  };
}
