{
  self,
  lib,
  inputs,
  machineDir,
  hostType,
  platform ? null,
  stateVersion ? null,
  ...
}:

let
  machineConfigurationPath = "${self}/system/machine/${machineDir}";
  machineConfigurationPathExist = builtins.pathExists machineConfigurationPath;
  machineModulesPath = "${self}/system/machine/${machineDir}/modules";
  machineModulesPathExist = builtins.pathExists machineModulesPath;
in
{
  imports =
    [
      "${self}/modules"
      "${self}/overlays/nixpkgs"
      "${self}/system/${hostType}/modules"
    ]
    ++ lib.optional machineConfigurationPathExist machineConfigurationPath
    ++ lib.optional machineModulesPathExist machineModulesPath;

  module.nix-config.enable = true;
  system = { inherit stateVersion; };

  nixpkgs = {
    hostPlatform = platform;

    overlays = [
      inputs.nix-topology.overlays.default
      inputs.proxmox-nixos.overlays.${platform}
    ];
  };
}
