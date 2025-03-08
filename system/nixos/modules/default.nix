{
  self,
  allDirs,
  ...
}: let
  modules = "${self}/system/nixos/modules";
in {
  imports = allDirs modules;
}
