{ pkgs, ... }:
{
  home.programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    plugins = with pkgs.yaziPlugins;{
      inherit lazygit;
      inherit full-border;
      inherit git;
      inherit smart-enter;
    };

    initLua = ''
      			require("full-border"):setup()
            require("git"):setup()
            require("smart-enter"):setup {
              open_multi = true,
            }
      		'';
  };
}

