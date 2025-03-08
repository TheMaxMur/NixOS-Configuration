{
  self,
  lib,
  config,
  username,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.module.fish;
in {
  options = {
    module.fish.enable = mkEnableOption "Enables Fish";
  };

  imports = [
    "${self}/home/modules/fish/starship"
  ];

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting
        set fish_cursor_default     block      blink
        set fish_cursor_insert      line       blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual      block

        function fish_user_key_bindings
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase insert
        end
      '';

      shellAliases = {
        "flake-update" = "nix flake update --flake /home/${username}/Code/nixos-configuration/";
        "darwin-update" = "darwin-rebuild switch --flake /Users/${username}/Code/nixos-configuration/";
        "h" = "history";
        "c" = "clear";
        "s" = "sudo su";

        # Git
        "gs" = "git status";
        "ga" = "git add";
        "ga." = "git add .";
        "gch" = "git checkout";
        "gchb" = "git checkout -b";
        "gc" = "git commit";
        "gcm" = "git commit -m";
        "gb" = "git branch";
        "mergemaster" = "git checkout master; git pull; git merge develop; git push; git checkout develop";
        "gfr" = "git fetch upstream && git rebase upstream/master";

        # Docker
        "di" = "docker images";
        "dr" = "docker run";
        "db" = "docker build";
        "dp" = "docker ps";
        "dps" = "docker ps -a";
        "drmi" = "docker rmi";
        "drm" = "docker rm";

        # Kubernetes
        "k" = "kubectl";

        # Pass
        "passc" = "pass -c";
        "upass" = "pass git pull; pass git push";

        # Others
        "gopenssl" = "/opt/cryptopack3/bin/openssl";
        "fuck" = "_ !!";
      };

      plugins = [
        {
          name = "autopair";
          inherit (pkgs.fishPlugins.autopair) src;
        }
        {
          name = "done";
          inherit (pkgs.fishPlugins.done) src;
        }
      ];
    };
  };
}
