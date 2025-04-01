{ pkgs, ... }:
{
  home.packages = with pkgs; [ pyprland ];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
      "expose",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "75% 60%"
    max_size = "1920px 100%"

    [scratchpads.volume]
    animation = "fromTop"
    command = "pavucontrol"
    class = "pavucontrol"
    lazy = true
    size = "40% 90%"

    [scratchpads.yazi]
    animation = "fromBottom"
    command = "ghostty -e yazi"
    class = "com.mitchellh.ghostty"
    position = "2% 6%"
    size = "96% 92%"

    [scratchpads.telegram-desktop]
    animation = "fromBottom"
    command = "telegram-desktop"
    class = "org.telegram.desktop"
    position = "2% 6%"
    size = "96% 92%"

    [scratchpads.thunar]
    animation = "fromBottom"
    command = "thunar"
    class = "thunar"
    size = "75% 70%"
  '';
}
