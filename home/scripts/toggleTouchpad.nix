{ host, pkgs, ... }:
let
  inherit (import ../../hosts/${host}/env.nix)
    touchpadID
    ;
in
pkgs.writeShellScriptBin "toggle_touchpad" ''

  HYPRLAND_DEVICE="${touchpadID}"
  HYPRLAND_VARIABLE="device[$HYPRLAND_DEVICE]:enabled"

  if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR=/run/user/$(id -u)
  fi

  export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

  enable_touchpad() {
      printf "true" >"$STATUS_FILE"
      swayosd-client --custom-message="Touchpad ON" --custom-icon=input-tablet
  hyprctl keyword $HYPRLAND_VARIABLE "true" -r
  }

  disable_touchpad() {
      printf "false" >"$STATUS_FILE"
      swayosd-client --custom-message="Touchpad OFF" --custom-icon=input-tablet
  hyprctl keyword $HYPRLAND_VARIABLE "false" -r
  }

  if ! [ -f "$STATUS_FILE" ]; then
    enable_touchpad
  else
    if [ $(cat "$STATUS_FILE") = "true" ]; then
      disable_touchpad
    elif [ $(cat "$STATUS_FILE") = "false" ]; then
      enable_touchpad
    fi
  fi
''
