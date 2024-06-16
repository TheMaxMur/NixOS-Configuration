{ pkgs
, inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.zsh;
in {
  options = {
    module.zsh.enable = mkEnableOption "Enables zsh";
  };

  config = mkIf cfg.enable {
    home.file.".p10k.zsh".source = ./p10k.zsh;
    home.file.".helmrc".source = ./helmrc;

    programs.zsh = {
      enable = true;

      plugins = with inputs; [
        {
          name = "powerlevel10k";
          file = "powerlevel9k.zsh-theme";
          src = powerlevel10k;
        }
        {
          name = "zsh-autosuggestions";
          file = "zsh-autosuggestions.plugin.zsh";
          src = zsh-autosuggestions;
        }
        {
          name = "zsh-history-substring-search";
          file = "zsh-history-substring-search.plugin.zsh";
          src = zsh-syntax-highlighting;
        }
        {
          name = "zsh-syntax-highlighting";
          file = "zsh-syntax-highlighting.plugin.zsh";
          src = zsh-syntax-highlighting;
        }
        {
          name = "zsh-auto-notify";
          file = "zsh-auto-notify.plugin.zsh";
          src = zsh-auto-notify;
        }
      ];

      oh-my-zsh = {
        enable = true;

        plugins = [
          "git"
          "vagrant"
          "docker"
          "python"
          "pass"
          "kubectl"
        ];

        extraConfig = ''
          zstyle ':omz:update' mode disabled
        '';
      };

      shellAliases = {
        # System
        "flake-update" = "nix flake update /home/maxmur/Code/nixos-configuration/";
        "darwin-update" = "darwin-rebuild switch --flake /Users/maxmur/Code/nixos-configuration/";
        "darwin-home-update" = "home-manager switch --flake /Users/maxmur/Code/nixos-configuration/.#maxmur@macbox";
        "ls" = "eza";
        "ll" = "eza -l";
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

      initExtraFirst = ''
        ${inputs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      '';

      initExtra = ''
        POWERLEVEL9K_MODE="nerdfont-complete"
        export PATH=$PATH:/home/maxmur/Downloads/android-studio/bin
        export PATH=$PATH:/home/maxmur/Downloads/git/flutter/bin/
        export ANDROID_HOME=/home/maxmur/.Android/sdk
        export PATH=$PATH:$ANDROID_HOME/tools
        export PATH=$PATH:$ANDROID_HOME/tools/bin
        export PATH=$PATH/:$ANDROID_HOME/platform-tools
        export GPG_TTY=$TTY

        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        [[ ! -f ~/.helmrc ]] || source ~/.helmrc
      '';
    };
  };
}

