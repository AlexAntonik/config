{
  pkgs,
  host,
  mkOutOfStoreSymlink,
  ...
}:
{
  hm.${host.username} = {
    home.packages = [
      pkgs.shellcheck
      pkgs.shfmt
    ];
    home.file = {
      ".config/Code/User/keybindings.json" = {
        source = mkOutOfStoreSymlink "${host.flakePath}/modules/vscode/keybindings.json";
        force = true;
      };
      ".config/Code/User/settings.json" = {
        source = mkOutOfStoreSymlink "${host.flakePath}/modules/vscode/settings.json";
        force = true;
      };
    };
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      mutableExtensionsDir = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          mikestead.dotenv
          christian-kohler.path-intellisense
          editorconfig.editorconfig
          vscodevim.vim
          alefragnani.project-manager
          jacobdufault.fuzzy-search

          dbaeumer.vscode-eslint
          esbenp.prettier-vscode
          usernamehw.errorlens
          yoavbls.pretty-ts-errors
          pflannery.vscode-versionlens
          eamodio.gitlens
          gruntfuggly.todo-tree

          bradlc.vscode-tailwindcss
          stylelint.vscode-stylelint
          wix.vscode-import-cost
          unifiedjs.vscode-mdx
          davidanson.vscode-markdownlint
          inferrinizzard.prettier-sql-vscode

          graphql.vscode-graphql
          graphql.vscode-graphql-syntax

          jnoortheen.nix-ide

          mads-hartmann.bash-ide-vscode
          mkhl.shfmt

          rangav.vscode-thunder-client
          vitest.explorer
          firefox-devtools.vscode-firefox-debug
          ms-vscode.test-adapter-converter
          formulahendry.code-runner

          golang.go
          ms-python.python
          ms-python.vscode-pylance
          ms-python.black-formatter
          tamasfe.even-better-toml
          ms-azuretools.vscode-containers
          ms-vscode.makefile-tools
          mechatroner.rainbow-csv

          donjayamanne.githistory
          ms-vsliveshare.vsliveshare
          bierner.color-info
        ];
      };
    };
  };
}
