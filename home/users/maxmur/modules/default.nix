{ self
, lib
, username
, ...
}:

let
  userModules = "${self}/home/users/${username}/modules";
in {
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${userModules}/${module}") (builtins.attrNames (builtins.readDir userModules))
  );
}

