{
  wayland.windowManager.hyprland.settings = {
    general = {
      layout = "dwindle";
      gaps_in = 0;
      gaps_out = 0;
      border_size = 0;
      resize_on_border = true;
    };
    decoration = {
      rounding = 0;
      dim_inactive = true;
      dim_strength = 0.16;
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
      };
    };

    animations = {
      enabled = true;
      bezier = [
        "overshot, 0.05, 0.9, 0.1, 1.00"
        "smoothOut, 0.5, 0, 0.99, 0.99"
        "smoothIn, 0.5, -0.5, 0.68, 1.0"
        "specialSlideOut, 0.16, 1, 0.3, 1"
        "specialSlideIn, 0.7, 0, 0.84, 0"
      ];
      animation = [
        "windows, 1, 4, overshot, slide"
        "windowsOut, 1, 2, smoothOut"
        "windowsIn, 1, 2, smoothOut"
        "windowsMove, 1, 3, smoothIn, slide"
        "border, 1, 4, default"
        "workspaces, 1, 4, default"
        "specialWorkspace, 1, 5, specialSlideOut, slidevert"
      ];
    };
  };
}
