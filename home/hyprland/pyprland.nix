{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [ pyprland ];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "ghostty --class=com.mitchellh.ghostty-dropterm"
    class = "com.mitchellh.ghostty-dropterm"
    lazy = true
    size = "76% 70%"
    position= "12% 10%"

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
    animation = "fromTop"
    pinned = false
    unfocus = "hide"
    hysteresis = 50 
    command = "telegram-desktop"
    class = "org.telegram.desktop"
    position = "2% 6%"
    size = "96% 92%"

    [scratchpads.thunar]
    animation = "fromBottom"
    command = "thunar"
    class = "thunar"
    position = "12% 18%"
    size = "76% 70%"
  '';
}
