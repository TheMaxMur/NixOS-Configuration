{ inputs
, ...
}:

{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = { config, ... }: {
    # For nix fmt
    treefmt.config = {
      projectRootFile = "flake.nix";

      programs = {
        deadnix.enable = true;
        statix.enable = true;
      };
    };
  };
}

