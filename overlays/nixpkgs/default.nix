{inputs, ...}: let
  baseSettings = {
    config = {
      allowBroken = true;
    };
  };

  permittedInsecurePackages = [];
  unfreeSettings =
    baseSettings
    // {
      config =
        baseSettings.config
        // {
          inherit permittedInsecurePackages;
          allowUnfree = true;
        };
    };
in {
  nixpkgs.overlays = [
    (final: _prev: {
      stable = import inputs.stable {inherit (final) system;} // baseSettings;
      stable-unfree = import inputs.stable {inherit (final) system;} // unfreeSettings;

      unstable = import inputs.unstable {inherit (final) system;} // baseSettings;
      unstable-unfree = import inputs.unstable {inherit (final) system;} // unfreeSettings;

      master = import inputs.master {inherit (final) system;} // baseSettings;
      master-unfree = import inputs.master {inherit (final) system;} // unfreeSettings;
    })
  ];
}
