{ self
, hostModules

, hostname
, ...
}:

let
  machineModules = "${self}/system/machine/${hostname}/modules";
in {
  imports = [
    "${hostModules}"
    "${machineModules}"
  ];

  module = {
    locales.enable  = true;
    network.enable  = true;
    security.enable = true;
    timedate.enable = true;
    users.enable    = true;
    pihole.enable   = true;
    
    programs = {
      gnupg.enable          = true;
      hm.enable             = true;
      nh.enable             = true;
      mtr.enable            = true;
      zsh.enable            = true;
      fish.enable           = true;
      systemPackages.enable = true;
    };
  };
}

