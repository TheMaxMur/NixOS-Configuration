{ self
, inputs
, ...
}:

let
  homeConfiguration   = "${self}/home";
  systemConfiguration = "${self}/system";

  homeModules         = "${homeConfiguration}/modules";
  systemModules       = "${systemConfiguration}/modules";
  commonModules       = "${self}/modules";
in {
  # DEPRECATED
  # Helper function for generating home-manager configs
  /* mkHome = { username ? "maxmur", wm ? null, hostname ? "nixos", isWorkstation ? false, platform ? "x86_64-linux" }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit inputs self wm homeModules commonModules username hostname stateVersion isWorkstation;
      };

      modules = [
        "${homeConfiguration}"
      ];
    }; */

  # Helper function for generating host configs
  mkHost = 
    { hostname ? "nixos"
    , username ? "maxmur"
    , stateVersion ? "24.05"
    , platform ? "x86_64-linux" 
    , isWorkstation ? false
    , wm ? null
    }:
    let
      machineConfigurationPath      = "${self}/system/machine/${hostname}";
      machineConfigurationPathExist = builtins.pathExists machineConfigurationPath;
      machineModulesPath            = "${self}/system/machine/${hostname}/modules";
      machineModulesPathExist       = builtins.pathExists machineModulesPath;

      swayEnable     = wm == "sway";
      hyprlandEnable = wm == "hyprland";
      wmEnable       = hyprlandEnable || swayEnable;
    in inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit 
          inputs
          self
          hostname
          username
          stateVersion
          platform
          isWorkstation
          wm
          homeModules
          commonModules
          systemModules
          machineConfigurationPath
          machineConfigurationPathExist
          machineModulesPath
          machineModulesPathExist
          hyprlandEnable
          swayEnable
          wmEnable;
      };

      modules = [
        "${systemConfiguration}"
        "${homeConfiguration}"
      ];
    };

  # Helper function for generating darwin host configs
  mkHostDarwin = 
    { hostname ? "mac"
    , username ? "maxmur"
    , stateVersion ? 6
    , platform ? "aarch64-darwin" 
    }:
    inputs.darwin.lib.darwinSystem {
      specialArgs = {
        inherit 
          inputs
          self
          hostname
          username
          platform
          stateVersion
          systemModules
          commonModules;
      };

      modules = [
        "${systemConfiguration}"
        "${homeConfiguration}"
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

