{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
  };
  home.file."./.config/ghostty/config".text = ''

    theme = Dracula+
    adjust-cell-height = 10%
    window-theme = dark
    window-height = 32
    window-width = 110
    background-opacity = 0.75
    background-blur-radius = 20
    selection-background = #2d3f76
    selection-foreground = #c8d3f5
    cursor-style = bar
    window-padding-balance = true
    window-padding-x = 0
    window-padding-y = 0
    window-padding-color = extend
    mouse-hide-while-typing = true
    keybind = alt+s>r=reload_config

    font-size = 13
    font-family = BerkeleyMono Nerd Font

    wait-after-command = false
    shell-integration = detect
    window-save-state = always
    gtk-single-instance = true
    unfocused-split-opacity = 0.5
    quick-terminal-position = center
    shell-integration-features = cursor,sudo
    
    keybind = ctrl+shift+c=copy_to_clipboard
    keybind = ctrl+shift+v=paste_from_clipboard
    keybind = performable:ctrl+v=paste_from_clipboard
  '';
}
