{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;

    profiles.default = { 
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions = with pkgs.open-vsx;
      [
        # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json

        # Essentials
        mikestead.dotenv
        editorconfig.editorconfig
        jacobdufault.fuzzy-search
        vscodevim.vim
        alefragnani.project-manager

        # Interface Improvements
        eamodio.gitlens
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
        denoland.vscode-deno

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
        mtxr.sqltools
        mtxr.sqltools-driver-pg
      ]
      ++ (with pkgs.vscode-marketplace; [
        # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
        dbaeumer.vscode-eslint
        mtxr.sqltools-driver-sqlite
        ms-vscode-remote.vscode-remote-extensionpack
        ms-vscode.remote-explorer
        ms-vsliveshare.vsliveshare
        codeforge.remix-forge
        amodio.toggle-excluded-files
      ]);
    };
  };
}