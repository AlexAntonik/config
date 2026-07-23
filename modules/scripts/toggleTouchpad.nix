{ touchpadID }:
{ pkgs, ... }:
{
  environment.systemPackages = [
   (pkgs.writeShellScriptBin
    "toggle_touchpad"
    ''
      HYPRLAND_DEVICE="${touchpadID}"

      if [ -z "$XDG_RUNTIME_DIR" ]; then
        export XDG_RUNTIME_DIR=/run/user/$(id -u)
      fi

      export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

      enable_touchpad() {
          printf "true" >"$STATUS_FILE"
          notify-send -i input-touchpad-on "Touchpad Enabled"
          hyprctl eval "hl.device({name = '$HYPRLAND_DEVICE', enabled = true })"
      }

      disable_touchpad() {
          printf "false" >"$STATUS_FILE"
          notify-send -i input-touchpad-off "Touchpad Disabled"
          hyprctl eval "hl.device({name = '$HYPRLAND_DEVICE', enabled = false })"
      }

      if ! [ -f "$STATUS_FILE" ]; then
        enable_touchpad
      else
        if [ "$(cat "$STATUS_FILE")" = "true" ]; then
          disable_touchpad
        elif [ "$(cat "$STATUS_FILE")" = "false" ]; then
          enable_touchpad
        fi
      fi
    '')
  ];
}
