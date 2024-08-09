{ hostModules
, ...
}:

let
  hostProgramModulesPath = "${hostModules}/programs";
in {
  imports = [
    "${hostProgramModulesPath}/systemPackages"
    "${hostProgramModulesPath}/home-manager"
    "${hostProgramModulesPath}/nix-helper"
    "${hostProgramModulesPath}/kdeconnect"
    "${hostProgramModulesPath}/xdg-portal"
    "${hostProgramModulesPath}/gnupg"
    "${hostProgramModulesPath}/zsh"
    "${hostProgramModulesPath}/mtr"
    "${hostProgramModulesPath}/dconf"
    "${hostProgramModulesPath}/fish"
  ];
}

