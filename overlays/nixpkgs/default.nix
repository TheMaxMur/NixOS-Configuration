{ self
, lib
, ...
}:

let
  overlaysPath = "${self}/overlays/nixpkgs";
in {
  # Read all directories from systemModules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${overlaysPath}/${module}") (builtins.attrNames (builtins.readDir overlaysPath))
  );
}

