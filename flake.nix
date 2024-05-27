{
  description = "MaxMur Flake";

  inputs = {
    # Official NixOS repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-local.url = "git+file:///home/maxmur/Code/nix/nixpkgs";

    # NixOS community
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    # MacOS configuration
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland ecosystem
    hyprland = {
      # url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=e419ef1873de01b0762f7f1a411994170a4d8cab";
      url = "github:hyprwm/Hyprland/v0.39.1";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    xdghypr = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Unoficial users flakes
    yandex-music.url = "github:cucumber-sp/yandex-music-linux";
    any-nix-shell.url = "github:TheMaxMur/any-nix-shell";
    cryptopro.url = "github:SomeoneSerge/pkgs";

    # Security
    sops-nix.url = "github:Mic92/sops-nix";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Just for pretty flake.nix
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Zsh plugins
    powerlevel10k = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };

    zsh-autosuggestions = {
      url = "github:zsh-users/zsh-autosuggestions";
      flake = false;
    };

    zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
      flake = false;
    };

    fzf-zsh-completions = {
      url = "github:chitoku-k/fzf-zsh-completions";
      flake = false;
    };

    zsh-history-substring-search = {
      url = "github:zsh-users/zsh-history-substring-search";
      flake = false;
    };

    zsh-auto-notify = {
      url = "github:MichaelAquilina/zsh-auto-notify";
      flake = false;
    };
  };

  outputs = { flake-parts, ... } @ inputs:
  let
    linuxArch          = "x86_64-linux";
    linuxArmArch       = "aarch64-linux";
    darwinArch         = "aarch64-darwin";
    stateVersion       = "24.05";
    stateVersionDarwin = 4;

    libx = import ./lib { inherit inputs stateVersion stateVersionDarwin; };
  in flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      linuxArch
      linuxArmArch
      darwinArch
    ];

    flake = {
      nixosConfigurations = {
        pcbox = libx.mkHost { hostname = "pcbox"; username = "maxmur"; isWorkstation = true ;  platform = linuxArch; };
        nbox  = libx.mkHost { hostname = "nbox";  username = "maxmur"; isWorkstation = true ;  platform = linuxArch; };
        rasp  = libx.mkHost { hostname = "rasp";  username = "maxmur"; isWorkstation = false ; platform = linuxArmArch; };
      };

      darwinConfigurations = {
        macbox = libx.mkHostDarwin { hostname = "macbox"; platform = darwinArch; };
      };

      homeConfigurations = {
        # pcbox
        "maxmur@pcbox"  = libx.mkHome { hostname = "pcbox";  username = "maxmur"; isWorkstation = true;  platform = linuxArch; };
        "root@pcbox"    = libx.mkHome { hostname = "pcbox";  username = "root";   isWorkstation = true;  platform = linuxArch; };

        # Nbox
        "maxmur@nbox"   = libx.mkHome { hostname = "nbox";   username = "maxmur"; isWorkstation = true;  platform = linuxArch; };
        "root@nbox"     = libx.mkHome { hostname = "nbox";   username = "root";   isWorkstation = true;  platform = linuxArch; };

        # Rasp
        "maxmur@rasp"   = libx.mkHome { hostname = "rasp";   username = "maxmur"; isWorkstation = false; platform = linuxArmArch; };
        "root@rasp"     = libx.mkHome { hostname = "rasp";   username = "root";   isWorkstation = false; platform = linuxArmArch; };

        # Macbox
        "maxmur@macbox" = libx.mkHome { hostname = "macbox"; username = "maxmur"; isWorkstation = true;  platform = darwinArch; };
      };
    };
  };
}

