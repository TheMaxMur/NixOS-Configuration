{
  programs = {
    starship = {
      enable = true;

      settings = {
        add_newline = false;

        format = ''
          [┌ ](bold blue)$username[@](bold blue)$hostname$kubernetes$directory$git_branch$git_commit$git_state$git_status$docker_context$package$golang$helm$java$cmake$julia$kotlin$lua$nim$nodejs$python$ruby$rust$swift$terraform$aws$gcloud$azure$nix_shell$fill$character$cmd_duration$time
          [└─> ](bold blue)
        '';

        fill.symbol = " ";

        character = {
          error_symbol = "[](bold red)";
          success_symbol = "[](bold green)";
          vimcmd_symbol = "[N](bold blue)";
          vimcmd_visual_symbol = "[V](bold red)";
          vimcmd_replace_one_symbol = "[R](bold purple)";
          vimcmd_replace_symbol = "[R](bold purple)";
        };

        username = {
          style_user = "blue bold";
          style_root = "red bold";
          format = "[$user]($style)";
          disabled = false;
          show_always = true;
        };

        hostname = {
          ssh_only = false;
          format = "[$hostname]($style) ";
          style = "blue bold";
          trim_at = ".";
          disabled = false;
        };

        nix_shell = {
          symbol = " ";
        };

        golang = {
          style = "blue";
          symbol = " ";
        };

        lua = {
          symbol = " ";
        };

        cmake = {
          style = "green";
          symbol = "△ ";
        };

        git_branch = {
          symbol = " ";
        };
        rust = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        docker_context = {
          symbol = " ";
        };

        time = {
          format = "[$time]($style) ";
          style = "bold blue";
          disabled = false;
        };

        cmd_duration = {
          format = "[$duration]($style) ";
          style = "bold blue";
        };

        status = {
          format = "[$symbol]($style) ";
          symbol = "[](bold red)";
          success_symbol = "[](bold green)";
          disabled = false;
        };

        directory = {
          read_only = " ";
          truncation_length = 7;
          truncation_symbol = "… /";
        };
      };
    };
  };
}
