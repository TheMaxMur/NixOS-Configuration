{ inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.nix-config;
in {
  options = {
    module.nix-config = {
      enable = mkEnableOption "Enables nix-config";

      useNixPackageManagerConfig = mkOption {
        type = types.bool;
        description = "Whether to use custom Nix package manager settings.";
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    # Nixpkgs config
    nixpkgs.config = {
      allowUnfree = true;

      permittedInsecurePackages = [
        "electron-27.3.11"
        "electron-25.9.0"
        "electron-19.1.9"
      ];
    };

    # Nix package manager settings
    nix = {
      registry.s.flake = inputs.self;

      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };

      gc = {
        automatic = true;
        options = "--delete-older-than 14d";
      };
    };
  };
}

