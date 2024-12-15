{ self
, lib
, ...
}:

{
  # Read all directories 
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${self}/home/modules/${module}") (builtins.attrNames (builtins.readDir "${self}/home/modules"))
  );
}

