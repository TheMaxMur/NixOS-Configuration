{ self
, hostname
, ...
}:

let
  machineModulesPath = "${self}/system/machine/${hostname}/modules";
in {
  imports = [
    "${machineModulesPath}/hardware"
    "${machineModulesPath}/ollama"
  ];
}

