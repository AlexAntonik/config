{ pkgs, ... }:
{
  home.packages = with pkgs; [ unstable.pyprland ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "pypr &"
    ];
  };

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "ghostty --class=com.mitchellh.ghostty-dropterm"
    class = "com.mitchellh.ghostty-dropterm"
    unfocus = "hide"
    lazy = true
    size = "76% 70%"
    position= "12% 10%"

    # [scratchpads.volume]
    # animation = "fromTop"
    # command = "pavucontrol"
    # class = "pavucontrol"
    # lazy = true
    # size = "40% 90%"

    # [scratchpads.yazi]
    # animation = "fromBottom"
    # command = "ghostty --class=com.mitchellh.ghostty-yazi -e yazi"
    # class = "com.mitchellh.ghostty-yazi"
    # lazy = true
    # position = "2% 2%"
    # size = "96% 92%"

    # [scratchpads.telegram-desktop]
    # animation = "fromTop"
    # pinned = false
    # lazy = true
    # unfocus = "hide"
    # # hysteresis = 10 
    # command = "telegram-desktop"
    # class = "org.telegram.desktop"
    # position = "2% 2%"
    # size = "96% 92%"

    # [scratchpads.thunar]
    # animation = "fromBottom"
    # command = "thunar"
    # class = "thunar"
    # lazy = true
    # position = "12% 12%"
    # size = "76% 70%"
  '';
}
