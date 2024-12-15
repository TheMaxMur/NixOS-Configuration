{ self
, machineDir
, lib
, ...
}:

let
  hardwareModulesPath = "${self}/system/machine/${machineDir}/modules/hardware";
in {
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${hardwareModulesPath}/${module}") (builtins.attrNames (builtins.readDir hardwareModulesPath))
  );
}

