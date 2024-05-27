_:

{
  networking = {
    nameservers = [
      "192.168.1.8"
    ];

    firewall = {
      enable = true;

      allowedTCPPorts = [
        22
        53
        80
        443
        4224
        5335
        8053
        8384
      ];

      allowedUDPPorts = [
        53
        5335
      ];
    };
  };
}

