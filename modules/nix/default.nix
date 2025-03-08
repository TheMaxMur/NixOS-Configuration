{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) bool;

  cfg = config.module.nix-config;
in {
  options = {
    module.nix-config = {
      enable = mkEnableOption "Enables nix-config";

      useNixPackageManagerConfig = mkOption {
        type = bool;
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
        "fluffychat-linux-1.23.0"
        "olm-3.2.16"
      ];
    };

    # Nix package manager settings
    nix = {
      package = pkgs.lix;
      registry.s.flake = inputs.self;

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        allowed-users = ["@wheel"];

        trusted-users = [
          "root"
          username
        ];

        substituters = [
          "https://hyprland.cachix.org"
          "https://nyx.chaotic.cx"
          "https://ghostty.cachix.org"
          "https://cache.saumon.network/proxmox-nixos"
          "https://nixpkgs-python.cachix.org"
          "https://devenv.cachix.org"
        ];

        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
          "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
          "proxmox-nixos:nveXDuVVhFDRFx8Dn19f1WDEaNRJjPrF2CPD2D+m1ys="
          "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        ];
      };
    };
  };
}
