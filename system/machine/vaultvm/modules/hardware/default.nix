{
  self,
  machineDir,
  allDirs,
  ...
}: let
  machineHardwareModulesPath = "${self}/system/machine/${machineDir}/modules/hardware";
in {
  imports = allDirs machineHardwareModulesPath;
}
