{ self
, lib
, ...
}:

let
  modules = "${self}/system/nixos/modules";
in {
  # Read all directories from modules
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${modules}/${module}") (builtins.attrNames (builtins.readDir modules))
  );
}

