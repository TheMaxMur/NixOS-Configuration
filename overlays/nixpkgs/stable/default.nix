{ inputs
, ...
}:

{
  nixpkgs.overlays = [
    # Default stable
    (final: _prev: {
      stable = import inputs.stable {
        inherit (final) system;
      };
    })

    # Unfree stable
    (final: _prev: {
      stable-unfree = import inputs.stable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    })
  ];
}

