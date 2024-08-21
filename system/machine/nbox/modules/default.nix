{ lib
, machineModulesPath
, ...
}:

{
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${machineModulesPath}/${module}") (builtins.attrNames (builtins.readDir machineModulesPath))
  );
}

