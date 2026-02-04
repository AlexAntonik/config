{
  flake.nixosModules.nvf =
    {
      inputs,
      ...
    }:
    {
      imports = [ inputs.nvf.nixosModules.default ];

      programs.nvf = {
        enable = true;

        settings.vim = {
          vimAlias = true;
          viAlias = true;
          withNodeJs = true;
          lineNumberMode = "relNumber";
          enableLuaLoader = true;

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
            transparent = true;
          };

          options = {
            tabstop = 2;
            shiftwidth = 2;
          };

          spellcheck = {
            enable = true;
            languages = [ "en" ];
          };

          lsp = {
            enable = true;
            formatOnSave = true;
            lspkind.enable = false;
            lightbulb.enable = true;
            lspsaga.enable = false;
            trouble.enable = true;
            lspSignature.enable = true;
            otter-nvim.enable = false;
            nvim-docs-view.enable = false;
          };

          clipboard = {
            enable = true;
            registers = "unnamedplus";
            providers = {
              wl-copy.enable = true;
              xsel.enable = true;
            };
          };

          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;

            go.enable = true;
            nix.enable = true;
            clang.enable = true;
            python.enable = true;
            sql.enable = true;
            yaml.enable = true;
            html.enable = true;
            java.enable = true;
            kotlin.enable = true;
            json.enable = true;
            bash.enable = true;
            lua.enable = true;
            css.enable = true;
            typst.enable = true;
            ts.enable = true;
          };

          visuals = {
            highlight-undo.enable = true;
            nvim-cursorline.enable = true;
            nvim-web-devicons.enable = true;
            cinnamon-nvim.enable = true;
            indent-blankline.enable = true;
            rainbow-delimiters.enable = true;
          };

          telescope.enable = true;
          statusline.lualine.enable = true;
          autopairs.nvim-autopairs.enable = true;
          autocomplete.nvim-cmp.enable = true;
          tabline.nvimBufferline.enable = true;
          comments.comment-nvim.enable = true;
          projects.project-nvim.enable = true;

          binds = {
            whichKey.enable = true;
            cheatsheet.enable = true;
          };

          git = {
            enable = true;
            gitsigns.enable = true;
            gitsigns.codeActions.enable = false; # throws an annoying debug message
          };
          ui = {
            borders.enable = true;
            noice.enable = true;
            smartcolumn.enable = true;
            colorizer.enable = true;
            illuminate.enable = true;
            fastaction.enable = true;
            breadcrumbs = {
              enable = false;
              navbuddy.enable = false;
            };
          };
        };
      };
    };
}
