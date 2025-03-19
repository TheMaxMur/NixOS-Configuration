{
  inputs,
  self,
  username,
  ...
}: {
  imports = [
    inputs.microvm.nixosModules.host
  ];

  microvm = {
    autostart = [
      "dnsvm"
      "dbvm"
      "gitvm"
      "vaultvm"
    ];

    vms = {
      dnsvm = {
        flake = self;
        updateFlake = "git+file:///home/${username}/Code/nixos-configuration";
      };

      dbvm = {
        flake = self;
        updateFlake = "git+file:///home/${username}/Code/nixos-configuration";
      };

      gitvm = {
        flake = self;
        updateFlake = "git+file:///home/${username}/Code/nixos-configuration";
      };

      vaultvm = {
        flake = self;
        updateFlake = "git+file:///home/${username}/Code/nixos-configuration";
      };
    };
  };
}
