_: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = 14;
      theme = "Dracula";
      background-opacity = 0.95;
      background-blur = 10;
      font-thicken = false;
      font-feature = ["ss04" "ss01"];
      bold-is-bright = false;
      adjust-box-thickness = 1;
      cursor-style = "bar";
      cursor-style-blink = false;
      copy-on-select = false;
      confirm-close-surface = false;
      adjust-cursor-thickness = 1;
      mouse-hide-while-typing = true;
      window-padding-x = 4;
      window-padding-y = 6;
      window-padding-balance = true;
      title = "GhosTTY";
      gtk-single-instance = true;
    };
  };
}
