{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    mutableExtensionsDir = false;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      userSettings = {
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono', 'Fira Code', monospace";
        "editor.fontFamily"= "'JetBrainsMono Nerd Font Mono', 'Fira Code', monospace";
        # "editor.fontFamily" = "'FiraCode Nerd Font', 'FiraCode Nerd Font Mono', 'monospace', monospace";
        "terminal.integrated.fontLigatures.featureSettings" = "\"liga\" on";
        "window.menuBarVisibility" = "toggle";
        "files.autoSave" = "afterDelay";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.cursorBlinking" = "phase";
        "editor.minimap.enabled" = false;
        "window.customTitleBarVisibility" = "never";
        "keyboard.dispatch" = "keyCode";
        "vim.useCtrlKeys" = true;
        "vim.useSystemClipboard" = true;
        "vim.handleKeys"."<Esc>" = true;
        "editor.lineNumbers" = "relative";
        "nix.serverPath"= "nixd";
        "nix.enableLanguageServer"= true;
        "nix.serverSettings" = {
            "nixd" = {
                "nixpkgs"= {
                    "expr"= "import (builtins.getFlake \"/home/alex/config\").inputs.nixpkgs { }";
                };
                "formatting"= {
                    "command"= [
                        "nixfmt"
                    ];
                };
                "options"= {
                    "nixos"= {
                        "expr"= "(builtins.getFlake \"/home/alex/config\").nixosConfigurations.alex.options";
                    };
                    "home_manager"= {
                        "expr"= "(builtins.getFlake \"/home/alex/config\").inputs.home-manager.lib";
                    };
                };
            };
        };
        "editor.fontSize" = 16;
        "[sql]"."editor.defaultFormatter" = "adpyke.vscode-sql-formatter";
        "window.controlsStyle" = "hidden";
        "workbench.activityBar.location" = "hidden";
        "explorer.confirmPasteNative" = false;

        "editor.inlineSuggest.enabled" = true;

        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableCommitSigning" = true;
        # "git.enableSmartCommit" = true;

        "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[markdown]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
        "[scss]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

        # "nix.enableLanguageServer" = true;
        # "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
        # "nix.serverPath" = "${pkgs.nil}/bin/nil";
        # "nix.serverSettings"."nil"."formatting"."command" = [ "${pkgs.alejandra}/bin/alejandra" ];

        "bashIde.shellcheckPath" = "${pkgs.shellcheck}/bin/shellcheck";
        "shfmt.executablePath" = "${pkgs.shfmt}/bin/shfmt";
      };
      keybindings = ./../dotfiles/vscode/keybindings.json;

      extensions =
        with pkgs.open-vsx;
        [
          # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json

          # Essentials
          mikestead.dotenv
          editorconfig.editorconfig
          jacobdufault.fuzzy-search
          vscodevim.vim
          alefragnani.project-manager

          # Interface Improvements
          # eamodio.gitlens
          usernamehw.errorlens
          pflannery.vscode-versionlens
          yoavbls.pretty-ts-errors
          wix.vscode-import-cost
          gruntfuggly.todo-tree
          zhuangtongfa.material-theme

          # Web Dev
          # dbaeumer.vscode-eslint
          esbenp.prettier-vscode
          csstools.postcss
          stylelint.vscode-stylelint
          bradlc.vscode-tailwindcss
          davidanson.vscode-markdownlint
          unifiedjs.vscode-mdx
          # zenclabs.previewjs # Error: EROFS: read-only file system

          # Deno
          # denoland.vscode-deno

          # GraphQL
          graphql.vscode-graphql-syntax
          graphql.vscode-graphql

          # Nix
          jnoortheen.nix-ide
          arrterian.nix-env-selector

          # Bash
          mads-hartmann.bash-ide-vscode
          mkhl.shfmt

          # Testing
          rangav.vscode-thunder-client
          vitest.explorer
          ms-playwright.playwright
          firefox-devtools.vscode-firefox-debug
          ms-vscode.test-adapter-converter
          # mtxr.sqltools
          # mtxr.sqltools-driver-pg
        ]
        ++ (with pkgs.vscode-marketplace; [
          # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
          dbaeumer.vscode-eslint
          # mtxr.sqltools-driver-sqlite
          ms-vscode-remote.vscode-remote-extensionpack
          ms-vscode.remote-explorer
          ms-vsliveshare.vsliveshare
          codeforge.remix-forge
          amodio.toggle-excluded-files
        ]);
    };
  };
}
