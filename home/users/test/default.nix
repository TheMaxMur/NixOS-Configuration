{
  pkgs,
  inputs,
  ...
}: {
  programs.home-manager.enable = true;

  home = {
    username = "test";
    stateVersion = "23.11";

    # Software
    packages = with pkgs; [
      # Utils
      inputs.any-nix-shell
    ];
  };
}
