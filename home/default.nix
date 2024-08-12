{ self
, pkgs
, lib
, inputs
, homeModules
, generalModules
, hostname
, platform
, isWorkstation
, username
, stateVersion
, ...
}:

let
  inherit (pkgs.stdenv) isDarwin;
  isRoot                     = if (username == "root") then true else false;
  homeDirectory              = if isDarwin then "/Users/${username}" else if isRoot then "/root" else "/home/${username}";
  userConfigurationPath      = "${self}/home/users/${username}";
  userConfigurationPathExist = builtins.pathExists userConfigurationPath;
in {
  home-manager = {
    useGlobalPkgs     = true;
    useUserPackages   = true;

    extraSpecialArgs  = {
      inherit inputs self homeModules generalModules hostname username platform stateVersion isWorkstation;
    };

    users.${username} = {
      programs.home-manager.enable = true;

      imports = lib.optional userConfigurationPathExist userConfigurationPath;

      home = {
        inherit username;
        inherit stateVersion;
        inherit homeDirectory;
      };
    };
  };
}

