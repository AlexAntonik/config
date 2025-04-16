{ username, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };
      background = [
        {
          path = "/home/${username}/Pictures/Wallpapers/town.jpg";
          blur_passes = 2;
          blur_size = 4;
        }
      ];
      label = [
        {
          text = "$TIME";
          color = "rgb(E5E9F0)";
          font_size = 156;
          font_family = "Cantarell";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo $(date '+%A')";  # Day of week
          color = "rgb(B7BCC4)";
          font_size = 32;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, 220";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo $(date '+%B %d')";  # Month and day
          color = "rgb(B7BCC4)";
          font_size = 24;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, 260";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          size = "300, 50";
          position = "0, -100";
          monitor = "";
          dots_center = true;
          fade_on_empty = true;
          font_color = "rgba(215, 215, 215, 1.0)";
          font_family = "JetBrains Mono Nerd Font";
          inner_color = "rgba(40, 40, 40, 0.5)";
          outer_color = "rgba(30, 30, 30, 0.3)";
          outline_thickness = 1;
          placeholder_text = "Enter Password...";
          shadow_passes = 1;
          rounding = 10;
        }
      ];
    };
  };
}
