{ pkgs
, lib
, self
, generalModules

, hostname
, platform
, stateVersion ? null
, stateVersionDarwin ? null
, ...
}:

let
  inherit (pkgs.stdenv) isDarwin;
  currentStateVersion           = if isDarwin then stateVersionDarwin else stateVersion;
  machineConfigurationPath      = "${self}/system/machine/${hostname}";
  machineConfigurationPathExist = builtins.pathExists machineConfigurationPath;
in {
  imports = [
    "${generalModules}"
  ]
  ++ lib.optional machineConfigurationPathExist machineConfigurationPath;

  module.nix-config.enable = true;

  # System version
  system.stateVersion = currentStateVersion;
  # HostPlatform
  nixpkgs.hostPlatform = platform;
}

