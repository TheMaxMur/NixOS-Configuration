{ self
, inputs
, stateVersion
, stateVersionDarwin
, ...
}:

let
  homeConfiguration = "${self}/home";
  hostConfiguration = "${self}/system";
  homeModules       = "${homeConfiguration}/modules";
  hostModules       = "${hostConfiguration}/modules";
  generalModules    = "${self}/modules";
in {
  # Helper function for generating home-manager configs
  mkHome = { username ? "maxmur", hostname ? "nixos", isWorkstation ? false, platform ? "x86_64-linux" }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit inputs self homeModules generalModules platform username hostname stateVersion isWorkstation;
      };

      modules = [
        "${homeConfiguration}"
      ];
    };

  # Helper function for generating host configs
  mkHost = { hostname ? "nixos", username ? "maxmur", isWorkstation ? false, platform ? "x86_64-linux" }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs self hostModules generalModules hostname username platform stateVersion isWorkstation;
      };

      modules = [
        "${hostConfiguration}"
      ];
    };

  # Helper function for generating darwin host configs
  mkHostDarwin = { hostname ? "mac", platform ? "aarch64-darwin" }:
    inputs.darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs self hostModules generalModules hostname platform stateVersionDarwin;
      };

      modules = [
        "${hostConfiguration}"
      ];
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}

