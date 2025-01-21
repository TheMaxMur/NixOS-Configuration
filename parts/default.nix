{
  lib,
  ...
}:

{
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: builtins.toString ./. + "/${module}") (
      builtins.attrNames (builtins.readDir (builtins.toString ./.))
    )
  );
}
