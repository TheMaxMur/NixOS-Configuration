{
  self,
  allDirs,
  ...
}:

let
  hostServicesModulesPath = "${self}/system/nixos/modules/services";
in
{
  imports = allDirs hostServicesModulesPath;
}
