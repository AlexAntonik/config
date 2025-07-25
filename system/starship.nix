{
  ...
}:

{
  programs = {
    # System wide(Root user) strarship configuration
    starship = {
      enable = true;
      settings = {
        format = "[╭](fg:current_line)[─](fg:current_line)[](fg:yellow)[ ](fg:primary bg:yellow)$sudo$username$hostname$directory$git_branch$git_status$git_metrics$nix_shell$fill$nodejs$bun$deno$golang$kotlin$c$java$python$docker_context$rust$php$dart$haskell$aws$cmd_duration$time$line_break$character";
        palette = "dracula";
        add_newline = true;

        palettes = {
          dracula = {
            foreground = "#F8F8F2";
            background = "#282A36";
            current_line = "#44475A";
            primary = "#1E1F29";
            box = "#44475A";
            blue = "#6272A4";
            cyan = "#8BE9FD";
            green = "#50FA7B";
            orange = "#FFB86C";
            pink = "#FF79C6";
            purple = "#BD93F9";
            red = "#FF5555";
            yellow = "#F1FA8C";
          };
        };

        directory = {
          format = "[](fg:box)[─](fg:current_line)[](fg:pink)[󰷏 ](fg:primary bg:pink)[](fg:pink bg:box)[$read_only]($read_only_style bg:box)[ $truncation_symbol$path](fg:foreground bg:box)[](fg:box)";
          home_symbol = "~";
          truncation_symbol = "…/";
          truncation_length = 4;
          read_only = " 󰏮";
          read_only_style = "bold red";
        };

        sudo = {
          format = "[$symbol](fg:primary bg:yellow)";
          symbol = "󱄻 ";
          disabled = false;
        };

        git_branch = {
          format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $branch](fg:foreground bg:box)";
          symbol = " ";
        };

        git_status = {
          format = "[( $all_status )](fg:foreground bg:box)";
        };

        git_metrics = {
          added_style = "bold green";
          deleted_style = "bold red";
          format = "[([+$added]($added_style bg:box) )([-$deleted]($deleted_style bg:box) )](fg:foreground bg:box)[](fg:box)";
          disabled = false;
        };

        nodejs = {
          format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
          detect_files = [
            "package.json"
            ".node-version"
            "!bunfig.toml"
            "!bun.lockb"
          ];
        };

        bun = {
          format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
          symbol = "🥟";
        };

        deno = {
          format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
          symbol = "🦕";
        };

        nix_shell = {
          symbol = " ";
          format = "[─](fg:current_line)[](fg:pink)[$symbol](fg:primary bg:pink)[](fg:pink bg:box)[ $state (\\($name\\))](fg:foreground bg:box)[](fg:box)";
        };

        c = {
          symbol = " ";
          format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        rust = {
          symbol = "";
          format = "[─](fg:current_line)[](fg:red)[$symbol](fg:primary bg:red)[](fg:red bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        golang = {
          symbol = "󰟓 ";
          format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        php = {
          symbol = "";
          format = "[─](fg:current_line)[](fg:purple)[$symbol](fg:primary bg:purple)[](fg:purple bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        java = {
          symbol = " ";
          format = "[─](fg:current_line)[](fg:orange)[$symbol](fg:primary bg:orange)[](fg:orange bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        dart = {
          symbol = " ";
          format = "[─](fg:current_line)[](fg:blue)[$symbol](fg:primary bg:blue)[](fg:blue bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        kotlin = {
          symbol = "";
          format = "[─](fg:current_line)[](fg:purple)[$symbol](fg:primary bg:purple)[](fg:purple bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        haskell = {
          symbol = "";
          format = "[─](fg:current_line)[](fg:pink)[$symbol](fg:primary bg:pink)[](fg:pink bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        python = {
          symbol = "";
          format = "[─](fg:current_line)[](fg:yellow)[$symbol](fg:primary bg:yellow)[](fg:yellow bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        docker_context = {
          symbol = "";
          format = "[─](fg:current_line)[](fg:blue)[$context](fg:primary bg:blue)[](fg:blue bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        };

        aws = {
          format = "[─](fg:current_line)[](fg:purple)[$symbol](fg:primary bg:purple)[](fg:purple bg:box)[ $profile](fg:foreground bg:box)[](fg:box)";
          symbol = "☁️";
        };

        fill = {
          symbol = "─";
          style = "fg:current_line";
        };

        cmd_duration = {
          min_time = 500;
          format = "[─](fg:current_line)[](fg:orange)[ ](fg:primary bg:orange)[](fg:orange bg:box)[ $duration ](fg:foreground bg:box)[](fg:box)";
        };

        shell = {
          format = "[─](fg:current_line)[](fg:blue)[ ](fg:primary bg:blue)[](fg:blue bg:box)[ $indicator](fg:foreground bg:box)[](fg:box)";
          disabled = false;
        };

        time = {
          format = "[─](fg:current_line)[](fg:purple)[󰦖 ](fg:primary bg:purple)[](fg:purple bg:box)[ $time](fg:foreground bg:box)[](fg:box) ";
          time_format = "%H:%M:%S";
          disabled = false;
        };

        username = {
          style_user = "white";
          style_root = "red bold";
          format = "[](fg:yellow bg:box)[ $user](fg:$style bg:box)";
          show_always = true;
        };

        hostname = {
          format = "[$ssh_symbol$hostname](fg:foreground bg:box)";
          ssh_symbol = "@";
        };

        character = {
          format = "[╰─$symbol](fg:current_line) ";
          success_symbol = "[](fg:bold green)";
          error_symbol = "[](fg:bold red)";
        };
      };
    };
  };
}
