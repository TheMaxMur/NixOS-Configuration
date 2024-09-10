{ inputs
, ...
}:

{
  nixpkgs.overlays = [
    # Default master
    (final: _prev: {
      master = import inputs.master {
        inherit (final) system;
      };
    })

    # Unfree master
    (final: _prev: {
      master-unfree = import inputs.master {
        inherit (final) system;
        config.allowUnfree = true;
      };
    })
  ];
}

