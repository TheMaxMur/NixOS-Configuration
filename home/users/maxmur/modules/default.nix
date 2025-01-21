{
  self,
  username,
  allDirs,
  ...
}:

let
  userModules = "${self}/home/users/${username}/modules";
in
{
  imports = allDirs userModules;
}
