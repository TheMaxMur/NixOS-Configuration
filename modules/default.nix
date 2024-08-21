{ lib
, commonModules
, ...
}:

{
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${commonModules}/${module}") (builtins.attrNames (builtins.readDir commonModules))
  );
}

