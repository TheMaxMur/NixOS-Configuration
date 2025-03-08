{
  perSystem = {pkgs, ...}: {
    # For nix develop
    devShells.default = pkgs.mkShell {
      name = "flake-template";
      meta.description = "DevShell for Flake";

      # Env
      EDITOR = "${pkgs.helix}/bin/hx";

      shellHook = ''
        exec fish
      '';

      packages = with pkgs; [
        yazi
        git
        curl
        helix
        fish
        tmux
        lynx
        ripgrep
        htop
        disko
        fzf
      ];
    };
  };
}
