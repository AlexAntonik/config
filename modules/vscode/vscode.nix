{
  pkgs,
  inputs,
  host,
  mkSymlinks,
  ...
}:
let
  pkgsFork = import inputs.nixpkgs-fork {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
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
          pkgsFork.vscode-extensions.jacobdufault.fuzzy-search

          dbaeumer.vscode-eslint
          esbenp.prettier-vscode
          usernamehw.errorlens
          yoavbls.pretty-ts-errors
          pkgsFork.vscode-extensions.pflannery.vscode-versionlens
          eamodio.gitlens
          gruntfuggly.todo-tree

          bradlc.vscode-tailwindcss
          stylelint.vscode-stylelint
          wix.vscode-import-cost
          unifiedjs.vscode-mdx
          davidanson.vscode-markdownlint
          pkgsFork.vscode-extensions.inferrinizzard.prettier-sql-vscode

          graphql.vscode-graphql
          graphql.vscode-graphql-syntax

          jnoortheen.nix-ide

          mads-hartmann.bash-ide-vscode
          mkhl.shfmt

          pkgsFork.vscode-extensions.rangav.vscode-thunder-client
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
