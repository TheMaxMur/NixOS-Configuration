{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = _: {
    # For nix fmt
    treefmt.config = {
      projectRootFile = "flake.nix";
      settings = {
        global.excludes = [
          "LICENSE"
          ".gitattributes"

          "*.png"
          "*.svg"
          "*.bp"
          "*.conf"
          "*.zsh"
          "**/*rc"
          "**/.gitkeep"

          "secrets/**"
        ];
      };

      programs = {
        deadnix.enable = true;
        statix.enable = true;
        shellcheck.enable = true;
        prettier.enable = true;

        alejandra.enable = true;
        stylua.enable = true;
        yamlfmt.enable = true;
      };
    };
  };
}
