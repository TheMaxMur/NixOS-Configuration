{ lib
, machineModulesPath
, ...
}:

let
  hardwareModulesPath = "${machineModulesPath}/hardware";
in {
  imports = builtins.filter (module: lib.pathIsDirectory module) (
    map (module: "${hardwareModulesPath}/${module}") (builtins.attrNames (builtins.readDir hardwareModulesPath))
  );
}

/*
{ self
, hostname
, ...
}:

let
  machineHardwareModulesPath = "${self}/system/machine/${hostname}/modules/hardware";
in {
  imports = [
    "${machineHardwareModulesPath}/extra-hardware"
    "${machineHardwareModulesPath}/graphics-card"
    "${machineHardwareModulesPath}/impermanence"
    "${machineHardwareModulesPath}/network"
    "${machineHardwareModulesPath}/kernel"
    "${machineHardwareModulesPath}/sound"
    "${machineHardwareModulesPath}/disks"
    "${machineHardwareModulesPath}/boot"
  ];
} */

