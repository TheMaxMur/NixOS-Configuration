{ generalModules
, ...
}:

{
  imports = [
    "${generalModules}/nix"
    "${generalModules}/stylix"
  ];
}

