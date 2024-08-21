{ systemModules
, lib
, ...
}:

let
  hostProgramModulesPath = "${systemModules}/programs";
in {
  # Import all program modules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${hostProgramModulesPath}/${module}") (builtins.attrNames (builtins.readDir hostProgramModulesPath))
  );
}

