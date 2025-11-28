{ env, pkgs, ... }:
pkgs.writeShellScriptBin "toggle_display" ''
  if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR=/run/user/$(id -u)
  fi

  export STATUS_FILE="${env.displayStatusFile}"

  enable_display() {
    printf "true" >"$STATUS_FILE"
    hyprctl dispatch dpms on
    brightnessctl -d ${env.keyboardLightID} s 100
    brightnessctl -d ${env.keyboardScreenOFFLightID} s 0
  }

  disable_display() {
    printf "false" >"$STATUS_FILE"
    hyprctl dispatch dpms off
    brightnessctl -d ${env.keyboardLightID} s 0
    brightnessctl -d ${env.keyboardScreenOFFLightID} s 100
  }

  if ! [ -f "$STATUS_FILE" ]; then
    enable_display
  else
    if [ $(cat "$STATUS_FILE") = "true" ]; then
      disable_display
    elif [ $(cat "$STATUS_FILE") = "false" ]; then
      enable_display
    fi
  fi
''