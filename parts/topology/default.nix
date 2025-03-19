{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.nix-topology.flakeModule
    ./timeweb
    ./home
  ];

  perSystem = _: {
    # For nix topology
    topology.modules = [
      (
        {config, ...}: let
          inherit
            (config.lib.topology)
            mkInternet
            mkConnection
            ;
        in {
          inherit (self) nixosConfigurations;

          nodes.internet = mkInternet {
            connections = [
              (mkConnection "mgts-bridge-router" "wan1")
              (mkConnection "vpntwvm" "ens3")
            ];
          };
        }
      )
    ];
  };
}
