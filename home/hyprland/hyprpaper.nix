{ username, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "/home/${username}/config/home/wallpapers/mountains.jpg"
        "/home/${username}/config/home/wallpapers/vertical.jpg"
      ];

      wallpaper = [
        "eDP-1,/home/${username}/config/home/wallpapers/mountains.jpg"
        "HDMI-A-1,/home/${username}/config/home/wallpapers/vertical.jpg"
      ];
    };
  };
}
