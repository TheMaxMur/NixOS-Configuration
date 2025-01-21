{
  self,
  machineDir,
  allDirs,
  ...
}:

let
  hardwareModulesPath = "${self}/system/machine/${machineDir}/modules/hardware";
in
{
  imports = allDirs hardwareModulesPath;
}
