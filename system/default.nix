{ pkgs
, lib

, hostname
, platform
, stateVersion ? null
, stateVersionDarwin ? null
, ...
}:

let
  inherit (pkgs.stdenv) isDarwin;
  currentStateVersion = if isDarwin then stateVersionDarwin else stateVersion;
in {
  imports = [
    ../modules/nix
  ]
  ++ lib.optional (builtins.pathExists (./. + "/machine/${hostname}")) ./machine/${hostname};

  module.nix-config.enable = true;

  # System version
  system.stateVersion = currentStateVersion;
  # HostPlatform
  nixpkgs.hostPlatform = platform;
}

