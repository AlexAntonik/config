{ env, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "/home/${env.username}/config/home/hyprland/wallpapers/mountains.jpg"
        "/home/${env.username}/config/home/hyprland/wallpapers/vertical.jpg"
      ];

      wallpaper = [
        "eDP-1,/home/${env.username}/config/home/hyprland/wallpapers/mountains.jpg"
        "HDMI-A-1,/home/${env.username}/config/home/hyprland/wallpapers/vertical.jpg"
      ];
    };
  };
}
