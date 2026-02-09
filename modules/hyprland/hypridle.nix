{
  keyboardLightID,
  keyboardScreenOFFLightID,
  ...
}:
let
  statusFile = "$XDG_RUNTIME_DIR/display.status"; #must be same with toggleDisplay script
in
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
            on-timeout = "hyprlock --grace 300";
          }
          {
            timeout = 900;
            on-timeout = "printf 'false' > ${statusFile} && hyprctl dispatch dpms off && brightnessctl -d ${keyboardLightID} s 0 && brightnessctl -d ${keyboardScreenOFFLightID} s 100";
            on-resume = "printf 'true' > ${statusFile} && hyprctl dispatch dpms on && brightnessctl -d ${keyboardLightID} s 100 && brightnessctl -d ${keyboardScreenOFFLightID} s 0";
          }
        ];
      };
    };
  };
}
