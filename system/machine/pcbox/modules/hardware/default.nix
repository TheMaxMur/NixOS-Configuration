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
    "${machineHardwareModulesPath}/network"
    "${machineHardwareModulesPath}/kernel"
    "${machineHardwareModulesPath}/sound"
    "${machineHardwareModulesPath}/disks"
    "${machineHardwareModulesPath}/boot"
  ];
}

