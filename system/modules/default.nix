{ inputs
, ...
}:

{
  imports = [
    inputs.stylix.nixosModules.stylix
    ../../modules/stylix

    ./locales
    ./network
    ./programs
    ./security
    ./services
    ./timedate
    ./users
    ./variables
    ./virtualization
    ./pihole
  ];
}

