{ pkgs, ... }:
let
  settings = import ./yazi.nix;
  keymap = import ./keymap.nix;
  theme = import ./theme.nix;
in {
  programs.yazi = {
    enable = true;
    settings = settings;
    keymap = keymap;
    enableZshIntegration = true;
    enableBashIntegration = true;
    theme = theme;
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

