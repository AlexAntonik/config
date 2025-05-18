{
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix)
    keyboardLightID
    keyboardScreenOFFLightID
    displayStatusFile
    ;
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
            on-timeout = "printf 'false' > ${displayStatusFile} && hyprctl dispatch dpms off && brightnessctl -d ${keyboardLightID} s 0 && brightnessctl -d ${keyboardScreenOFFLightID} s 100";
            on-resume = "printf 'true' > ${displayStatusFile} && hyprctl dispatch dpms on && brightnessctl -d ${keyboardLightID} s 100 && brightnessctl -d ${keyboardScreenOFFLightID} s 0";
          }

          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
        ];
      };
    };
  };
}
