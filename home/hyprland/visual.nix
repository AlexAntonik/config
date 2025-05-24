{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    # Window decoration settings
        # General window manager settings
    general = {
      "$modifier" = "SUPER";
      layout = "dwindle"; # Tiling layout engine
      gaps_in = 0; # Gaps between windows
      gaps_out = 0; # Gaps between windows and screen edges
      border_size = 0; # Window border size
      resize_on_border = true; # Allow resizing by dragging border
    };
    decoration = {
      rounding = 0; # Window corner rounding
      dim_inactive = true;
      dim_strength = 0.20;
      blur = {
        enabled = true;
        size = 3;
        passes = 3;
        ignore_opacity = false;
        new_optimizations = true;
      };
      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)"; # Shadow color
      };
    };

    # Animation settings
    animations = {
      enabled = true;
      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.1"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
      ];
      animation = [
        "windows, 1, 6, wind, slide"
        "windowsIn, 1, 6, winIn, slide"
        "windowsOut, 1, 5, winOut, slide"
        "windowsMove, 1, 5, wind, slide"
        "border, 1, 1, liner"
        "fade, 1, 10, default"
        "workspaces, 1, 5, wind"
      ];
    };
  };
}