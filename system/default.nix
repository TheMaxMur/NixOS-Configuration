{ lib
, commonModules
, systemModules
, machineConfigurationPath
, machineConfigurationPathExist
, machineModulesPath
, machineModulesPathExist
, platform ? null
, stateVersion ? null
, ...
}:

{
  imports = [
    "${commonModules}"
    "${systemModules}"
  ]
  ++ lib.optional machineConfigurationPathExist machineConfigurationPath
  ++ lib.optional machineModulesPathExist machineModulesPath;

  module.nix-config.enable = true;

  # System version
  system = { inherit stateVersion; };
  # HostPlatform
  nixpkgs.hostPlatform = platform;
}

