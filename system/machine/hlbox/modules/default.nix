{ self
, machineDir
, lib
, ...
}:

let
  modules = "${self}/system/machine/${machineDir}/modules";
in {
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${modules}/${module}") (builtins.attrNames (builtins.readDir modules))
  );
}

