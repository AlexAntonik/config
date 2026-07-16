{ inputs, ... }:
{
  imports = [ inputs.nvf.nixosModules.default ];

  environment.shellAliases = {
    sv = "sudo nvim";
    v = "nvim";
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

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

      telescope.enable = true;

      visuals = {
        highlight-undo.enable = true;
        nvim-cursorline.enable = true;
        nvim-web-devicons.enable = true;
        cinnamon-nvim.enable = true;
        indent-blankline.enable = true;
        rainbow-delimiters.enable = true;
      };
    };
  };
}
