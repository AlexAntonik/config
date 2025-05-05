{
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix)
    keyboardLightID
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
            on-timeout = "hyprctl dispatch dpms off && brightnessctl -d ${keyboardLightID} s 0";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -d ${keyboardLightID} s 100";
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
