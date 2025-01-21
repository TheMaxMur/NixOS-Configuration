{
  self,
  machineDir,
  allDirs,
  ...
}:

let
  modules = "${self}/system/machine/${machineDir}/modules";
in
{
  imports = allDirs modules;
}
