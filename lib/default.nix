{ self
, inputs
, ...
}:

let
  defaultStateVersion = "24.11";

  allDirs =
    dirName:
    builtins.filter (
      module: ((builtins.pathExists module) && ((builtins.readFileType module) == "directory"))
    ) (map (module: "${dirName}/${module}") (builtins.attrNames (builtins.readDir dirName)));

  # Helper function for generating host configs
  mkHost = machineDir:
    { username ? "user"
    , stateVersion ? defaultStateVersion
    , hmStateVersion ? stateVersion
    , platform ? "x86_64-linux" 
    , hostname ? machineDir
    , isWorkstation ? false
    , wm ? null
    }:
    let
      swayEnable     = wm == "sway";
      hyprlandEnable = wm == "hyprland";
      wmEnable       = hyprlandEnable || swayEnable;
    in inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit 
          inputs
          self
          allDirs
          hostname
          username
          stateVersion
          hmStateVersion
          platform
          machineDir
          isWorkstation
          wm
          hyprlandEnable
          swayEnable
          wmEnable;
      };

      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.impermanence.nixosModules.impermanence
        inputs.disko.nixosModules.disko
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.chaotic.nixosModules.default
        inputs.nix-topology.nixosModules.default
        inputs.nur.modules.nixos.default
        inputs.proxmox-nixos.nixosModules.proxmox-ve
        inputs.sops-nix.nixosModules.sops

        "${self}/system/nixos/modules"
        "${self}/system"
        "${self}/home"
      ];
    };

  # Helper function for generating darwin host configs
  mkHostDarwin = machineDir:
    { username ? "user"
    , stateVersion ? 6
    , hmStateVersion ? defaultStateVersion
    , hostname ? machineDir
    , platform ? "aarch64-darwin" 
    , isWorkstation ? false
    , wm ? null
    }:
    let
      swayEnable     = wm == "sway";
      hyprlandEnable = wm == "hyprland";
      wmEnable       = hyprlandEnable || swayEnable;
    in inputs.darwin.lib.darwinSystem {
      specialArgs = {
        inherit 
          inputs
          self
          allDirs
          hostname
          username
          platform
          isWorkstation
          machineDir
          stateVersion
          hmStateVersion
          wm
          hyprlandEnable
          swayEnable
          wmEnable;
      };

      modules = [
        inputs.home-manager.darwinModules.home-manager
        inputs.stylix.darwinModules.stylix

        "${self}/system/darwin/modules"
        "${self}/system"
        "${self}/home"
      ];
    };
in {
  forAllSystems = inputs.nixpkgs.lib.systems.flakeExposed;

  # This function just add mkHost or mkHostDarwin before hosts attrset
  # ex: pcbox = { username = "test"; stateVersion = "24.11"; }; ->
  # pcbox = mkHost { username = "test"; stateVersion = "24.11"; };
  genNixos  = builtins.mapAttrs mkHost;
  genDarwin = builtins.mapAttrs mkHostDarwin;
}

