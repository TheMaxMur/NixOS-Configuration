{ self
, hostname
, ...
}:

let
  machineModulesPath = "${self}/system/machine/${hostname}/modules";
in {
  imports = [
    "${machineModulesPath}/temp-control"
    "${machineModulesPath}/hardware"
    "${machineModulesPath}/nginx"
  ];
}

