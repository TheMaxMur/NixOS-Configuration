{ self
, lib
, ...
}:

let
  hostProgramModulesPath = "${self}/system/nixos/modules/programs";
in {
  # Import all program modules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${hostProgramModulesPath}/${module}") (builtins.attrNames (builtins.readDir hostProgramModulesPath))
  );
}

