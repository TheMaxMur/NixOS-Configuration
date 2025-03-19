{
  self,
  pkgs,
  lib,
  inputs,
  hostname,
  username,
  platform,
  hmStateVersion,
  isWorkstation ? false,
  wm ? "",
  theme,
  swayEnable ? false,
  hyprlandEnable ? false,
  wmEnable ? false,
  allDirs,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;
  inherit (pkgs.stdenv) isLinux;
  inherit (lib) optional;

  stateVersion = hmStateVersion;
  isRoot = username == "root";
  homeDirectory =
    if isDarwin
    then "/Users/${username}"
    else if isRoot
    then "/root"
    else "/home/${username}";
  userConfigurationPath = "${self}/home/users/${username}";
  userConfigurationPathExist = builtins.pathExists userConfigurationPath;
  userModulesPath = "${self}/home/users/${username}/modules";
  userModulesPathExist = builtins.pathExists userModulesPath;
  # sshModulePath = "${self}/home/modules/ssh";
  # sshModuleExistPath = builtins.pathExists sshModulePath;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension =
      "backup-"
      + pkgs.lib.readFile "${pkgs.runCommand "timestamp" {} "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";

    extraSpecialArgs = {
      inherit
        inputs
        self
        allDirs
        hostname
        username
        platform
        stateVersion
        isLinux
        isWorkstation
        wm
        theme
        swayEnable
        hyprlandEnable
        wmEnable
        ;
    };

    users.${username} = {
      imports =
        [
          inputs.impermanence.nixosModules.home-manager.impermanence
          inputs.sops-nix.homeManagerModules.sops
          inputs.nur.modules.homeManager.default
          inputs.nvf.homeManagerModules.default

          "${self}/modules"
          "${self}/home/modules"
        ]
        ++ optional userConfigurationPathExist userConfigurationPath
        ++ optional userModulesPathExist userModulesPath;

      home = {
        inherit username;
        inherit stateVersion;
        inherit homeDirectory;
      };
    };
  };
}
