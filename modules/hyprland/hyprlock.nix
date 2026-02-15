{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
        fail_timeout = 800;
      };
      background = {
        monitor = "";
        path = "screenshot";
        blur_passes = 3;
        blur_size = 5;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.5172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
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
          text = "cmd[update:1000] echo $(date '+%A')";
          color = "rgb(D8DEE9)";
          font_size = 32;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, 220";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo $(date '+%B %d')";
          color = "rgb(D8DEE9)";
          font_size = 24;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, 260";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:400] echo $(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')";
          color = "rgb(B7BCC4)";
          font_size = 24;
          font_family = "JetBrains Mono Nerd Font";
          position = "20, 20";
          halign = "left";
          valign = "bottom";
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
