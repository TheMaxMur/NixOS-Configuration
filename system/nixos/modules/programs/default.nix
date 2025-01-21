{
  self,
  allDirs,
  ...
}:

let
  hostProgramModulesPath = "${self}/system/nixos/modules/programs";
in
{
  imports = allDirs hostProgramModulesPath;
}
