{ lib
, config
, pkgs
, inputs
, ...
}:

with lib;

let
  cfg = config.module.fish;
in {
  options = {
    module.fish.enable = mkEnableOption "Enables Fish";
  };

  imports = [
    ./starship
  ];

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting

        function fish_user_key_bindings
          fish_vi_key_bindings
        end

        ${inputs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

      '';

      shellAliases = {
        "flake-update" = "nix flake update /home/maxmur/Code/nixos-configuration/";
        "darwin-update" = "darwin-rebuild switch --flake /Users/maxmur/Code/nixos-configuration/";
        "darwin-home-update" = "home-manager switch --flake /Users/maxmur/Code/nixos-configuration/.#maxmur@macbox";
        "tree" = "eza --tree -L 3";
        "ls" = "eza";
        # "ll" = "eza -l";
        "l" = "eza --icons -F -H --group-directories-first --git";
        "ll" = "eza --icons -F -H --group-directories-first --git -all";
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

        # Pass
        "passc" = "pass -c";
        "upass" = "pass git pull; pass git push";

        # Others
        "gopenssl" = "/opt/cryptopack3/bin/openssl";
        "fuck" = "_ !!";
        "minecraft" = "java -jar /home/maxmur/Games/TLauncher-2.86.jar";
        "sudo" = "doas";
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

