{
  imports = [
    ./nvim-base.nix
  ];

  xdg.mime.defaultApplications = {
    "text/plain" = "nvim.desktop";
    "application/json" = "nvim.desktop";
    "application/yaml" = "nvim.desktop";
  };
  programs.nvf = {
    settings.vim = {
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

      languages = {
        go.enable = true;
        nix.enable = true;
        python.enable = true;
        sql.enable = true;
        yaml.enable = true;
        html.enable = true;
        json.enable = true;
        bash.enable = true;
        lua.enable = true;
        css.enable = true;
        typst.enable = true;
        typescript.enable = true;
      };

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
        gitsigns.codeActions.enable = false;
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
}
