{ self
, lib
, ...
}:

{
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${self}/modules/${module}") (builtins.attrNames (builtins.readDir "${self}/modules"))
  );
}

