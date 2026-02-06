{ pkgs, ... }:
{
  home.programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    plugins = {
      lazygit = pkgs.yaziPlugins.lazygit;
      full-border = pkgs.yaziPlugins.full-border;
      git = pkgs.yaziPlugins.git;
      smart-enter = pkgs.yaziPlugins.smart-enter;
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

