{ inputs
, ...
}:

{
  nixpkgs.overlays = [
    # Default unstable
    (final: _prev: {
      unstable = import inputs.unstable {
        inherit (final) system;
      };
    })

    # Unfree unstable
    (final: _prev: {
      unstable-unfree = import inputs.unstable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    })
  ];
}

