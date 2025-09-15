{ username, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "/home/${username}/config/home/hyprlandG/wallpapers/mountains.jpg"
        "/home/${username}/config/home/hyprland/wallpapers/vertical.jpg"
      ];

      wallpaper = [
        "eDP-1,/home/${username}/config/home/hyprland/wallpapers/mountains.jpg"
        "HDMI-A-1,/home/${username}/config/home/hyprland/wallpapers/vertical.jpg"
      ];
    };
  };
}
