{ pkgs, ... }:
let
  installScript = pkgs.writeShellScriptBin "setvslinks" ''
    create_symlink() {
      local source=$1
      local target=$2
      
      # Check if source exists and resolve it
      if [ ! -e "$source" ]; then
        echo "Error: Source file $source does not exist"
        return 1
      fi
      
      # Resolve source to its final destination to prevent cycles
      local real_source=$(readlink -f "$source")
      
      # Remove existing symlink if it exists
      if [ -L "$target" ]; then
        rm "$target"
      # Backup existing regular file if it exists
      elif [ -f "$target" ]; then
        mv "$target" "$target.backup"
      fi
      
      # Create the symlink using resolved path
      ln -s "$real_source" "$target"
    }

    # Ensure target directory exists
    mkdir -p "$HOME/.config/Code/User"

    # Create symbolic links for VS Code configuration
    create_symlink "$HOME/config/home/vscode/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
    create_symlink "$HOME/config/home/vscode/settings.json" "$HOME/.config/Code/User/settings.json"

  '';
in
{
  home.packages = with pkgs;[
    installScript
    shellcheck # Shell script analysis tool
    shfmt # Shell script formatter
  ];
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "setvslinks"
    ];
  };
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    mutableExtensionsDir = true;
    profiles.default = {
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
          # arrterian.nix-env-selector #like dev shells not needed rn

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
          bierner.color-info
          golang.go
          # mtxr.sqltools-driver-sqlite
          tamasfe.even-better-toml
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.vscode-remote-extensionpack
          ms-vscode.remote-explorer
          adpyke.vscode-sql-formatter
          ms-vsliveshare.vsliveshare
          # codeforge.remix-forge
          amodio.toggle-excluded-files
          # github.copilot
          # github.copilot-chat
        ]); # remome ';' to add copilot
      # ++(with pkgs.unstable;[
      # vscode-extensions.github.copilot
      # vscode-extensions.github.copilot-chat
      # ]);
    };
  };
}
