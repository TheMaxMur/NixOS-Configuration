{ systemModules
, lib
, ...
}:

let
  hostServicesModulesPath = "${systemModules}/services";
in {
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${hostServicesModulesPath}/${module}") (builtins.attrNames (builtins.readDir hostServicesModulesPath))
  );
}

