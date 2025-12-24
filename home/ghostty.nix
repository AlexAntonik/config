{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {
      theme = "Dracula+";
      background-opacity = 0.75;
      background-blur-radius = 20;
      cursor-style = "bar";
      window-padding-balance = true;
      window-padding-x = 0;
      window-padding-y = 0;
      window-padding-color = "extend";
      window-show-tab-bar = "never";
      window-decoration = false;

      font-size = 13;
      adjust-cell-height = 10;
      font-family = "BerkeleyMono Nerd Font";
      wait-after-command = false;
      mouse-hide-while-typing = true;
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo";
      window-save-state = "always";
      gtk-single-instance = true;

      keybind = [
        "alt+r=reload_config"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "performable:ctrl+v=paste_from_clipboard"
        "alt+enter=new_tab"
        "alt+q=close_tab"
        "alt+s=toggle_tab_overview"
      ];
    };
  };
}
