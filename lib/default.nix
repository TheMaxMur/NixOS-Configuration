{
  self,
  inputs,
  ...
}: let
  defaultStateVersion = "24.11";

  constructors = [
    "${self}/home"
    "${self}/system"
  ];

  allDirs = dirName:
    builtins.filter (
      module: ((builtins.pathExists module) && ((builtins.readFileType module) == "directory"))
    ) (map (module: "${dirName}/${module}") (builtins.attrNames (builtins.readDir dirName)));

  # Helper function for generating host configs
  mkHost = machineDir: {
    username ? "user",
    stateVersion ? defaultStateVersion,
    hmStateVersion ? stateVersion,
    platform ? "x86_64-linux",
    hostname ? machineDir,
    isWorkstation ? false,
    wm ? null,
    theme ? "nord",
    hostType ? "nixos",
  }: let
    swayEnable = wm == "sway";
    hyprlandEnable = wm == "hyprland";
    wmEnable = hyprlandEnable || swayEnable;
    nixosSystem =
      if stateVersion == defaultStateVersion
      then inputs.stable.lib.nixosSystem
      else inputs.nixpkgs.lib.nixosSystem;
  in
    nixosSystem {
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
          theme
          hyprlandEnable
          swayEnable
          wmEnable
          hostType
          ;
      };

      modules = with inputs;
        [
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          impermanence.nixosModules.impermanence
          disko.nixosModules.disko
          lanzaboote.nixosModules.lanzaboote
          chaotic.nixosModules.default
          nix-topology.nixosModules.default
          proxmox-nixos.nixosModules.proxmox-ve
          sops-nix.nixosModules.sops
          nur.modules.nixos.default
        ]
        ++ constructors;
    };

  # Helper function for generating darwin host configs
  mkHostDarwin = machineDir: {
    username ? "user",
    stateVersion ? 6,
    hmStateVersion ? defaultStateVersion,
    hostname ? machineDir,
    platform ? "aarch64-darwin",
    isWorkstation ? false,
    wm ? null,
    theme ? "nord",
    hostType ? "darwin",
  }: let
    swayEnable = wm == "sway";
    hyprlandEnable = wm == "hyprland";
    wmEnable = hyprlandEnable || swayEnable;
  in
    inputs.darwin.lib.darwinSystem {
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
          theme
          hyprlandEnable
          swayEnable
          wmEnable
          hostType
          ;
      };

      modules = with inputs;
        [
          home-manager.darwinModules.home-manager
          stylix.darwinModules.stylix
        ]
        ++ constructors;
    };
in {
  forAllSystems = inputs.nixpkgs.lib.systems.flakeExposed;

  # This function just add mkHost or mkHostDarwin before hosts attrset
  # ex: pcbox = { username = "test"; stateVersion = "24.11"; }; ->
  # pcbox = mkHost { username = "test"; stateVersion = "24.11"; };
  genNixos = builtins.mapAttrs mkHost;
  genDarwin = builtins.mapAttrs mkHostDarwin;
}
