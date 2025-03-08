{
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages.mydocs = pkgs.callPackage ./docs.nix {self = self';};
  };
}
