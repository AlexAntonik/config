{
  pkgs,
  inputs,
  host,
  mkSymlinks,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      vscode-extensions = prev.vscode-extensions // {
        jacobdufault.fuzzy-search =
          (import inputs.nixpkgs-fork { system = prev.system; }).vscode-extensions.jacobdufault.fuzzy-search;
        inferrinizzard.prettier-sql-vscode =
          (import inputs.nixpkgs-fork { system = prev.system; })
          .vscode-extensions.inferrinizzard.prettier-sql-vscode;
        rangav.vscode-thunder-client =
          (import inputs.nixpkgs-fork {
            system = prev.system;
            config.allowUnfree = true;
          }).vscode-extensions.rangav.vscode-thunder-client;
        pflannery.vscode-versionlens =
          (import inputs.nixpkgs-fork { system = prev.system; })
          .vscode-extensions.pflannery.vscode-versionlens;
      };
    })
  ];
  system.activationScripts = mkSymlinks "vscode" {
    "/home/${host.username}/.config/Code/User/keybindings.json" =
      "${host.flakePath}/modules/vscode/keybindings.json";
    "/home/${host.username}/.config/Code/User/settings.json" =
      "${host.flakePath}/modules/vscode/settings.json";
  };
  home = {
    home.packages = [
      pkgs.shellcheck
      pkgs.shfmt
    ];
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
          tamasfe.even-better-toml
          ms-azuretools.vscode-containers
          ms-vscode.makefile-tools

          donjayamanne.githistory
          ms-vsliveshare.vsliveshare
          bierner.color-info
        ];
      };
    };
  };
}
