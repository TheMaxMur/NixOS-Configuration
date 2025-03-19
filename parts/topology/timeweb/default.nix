{self, ...}: {
  perSystem = _: {
    # For nix topology
    topology.modules = [
      (
        _: {
          inherit (self) nixosConfigurations;

          networks = {
            netbird-private = {
              name = "NetBird private";
              cidrv4 = "100.92.0.0/16";
            };
          };
        }
      )
    ];
  };
}
