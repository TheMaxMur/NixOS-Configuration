{
  description = "MaxMur Flake";

  inputs = {
    # Official NixOS repo
    master = {
      url = "github:NixOS/nixpkgs/master";
    };

    unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # Latest stable
    stable = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    # Current nixpkgs branch
    nixpkgs = {
      follows = "unstable";
    };

    # NixOS community
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:/nix-community/impermanence";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };

    nix-topology = {
      url = "github:oddlama/nix-topology";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # MacOS configuration
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland ecosystem
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=c5feee1e357f3c3c59ebe406630601c627807963";
    };

    xdghypr = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland/v1.3.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Unoficial users flakes
    yandex-music = {
      url = "github:cucumber-sp/yandex-music-linux";
    };

    any-nix-shell = {
      url = "github:TheMaxMur/any-nix-shell";
    };

    cryptopro = {
      url = "github:SomeoneSerge/pkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";

      inputs = {
        nixpkgs-stable.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs";
      };
    };

    proxmox-nixos = {
      url = "github:SaumonNet/proxmox-nixos";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Security
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs: let
    # Description of hosts
    hosts = import ./hosts.nix;

    # Import helper funcfions
    libx = import ./lib {inherit self inputs;};
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = libx.forAllSystems;

      imports = [
        ./parts
        # ./docs
      ];

      flake = {
        # NixOS Hosts configuration
        nixosConfigurations = libx.genNixos hosts.nixos;

        # MacOS Hosts configuration
        darwinConfigurations = libx.genDarwin hosts.darwin;

        # Templates
        templates = import "${self}/templates" {inherit self;};
      };
    };
}
