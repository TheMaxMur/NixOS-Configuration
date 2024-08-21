{ systemModules
, lib
, ...
}:

{
  # Read all directories from systemModules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${systemModules}/${module}") (builtins.attrNames (builtins.readDir systemModules))
  );
}

