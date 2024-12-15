{ self
, lib
, ...
}:

let
  hostServicesModulesPath = "${self}/system/nixos/modules/services";
in {
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${hostServicesModulesPath}/${module}") (builtins.attrNames (builtins.readDir hostServicesModulesPath))
  );
}

