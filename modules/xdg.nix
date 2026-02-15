{ pkgs, ... }:
{
  home.xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland  # Hyprland-specific portal
        pkgs.xdg-desktop-portal-gtk       # GTK fallback
      ];
      config.common.default = [ "hyprland" "gtk" ];
    };
  };
}
