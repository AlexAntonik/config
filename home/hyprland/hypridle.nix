{
  env,
  ...
}:
{
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 600;
            on-timeout = "hyprlock";
          }
          {
            timeout = 900;
            on-timeout = "printf 'false' > ${env.displayStatusFile} && hyprctl dispatch dpms off && brightnessctl -d ${env.keyboardLightID} s 0 && brightnessctl -d ${env.keyboardScreenOFFLightID} s 100";
            on-resume = "printf 'true' > ${env.displayStatusFile} && hyprctl dispatch dpms on && brightnessctl -d ${env.keyboardLightID} s 100 && brightnessctl -d ${env.keyboardScreenOFFLightID} s 0";
          }
        ];
      };
    };
  };
}
