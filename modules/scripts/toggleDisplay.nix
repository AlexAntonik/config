{host,  pkgs,  ...}:
let
  statusFile = "$XDG_RUNTIME_DIR/display.status"; # must be same with hipridle
  kbLightID = host.keyboardLightID;
  kbScreenOFFLightID = host.keyboardScreenOFFLightID;
in
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin
    "toggle_display"
    ''
      if [ -z "$XDG_RUNTIME_DIR" ]; then
        export XDG_RUNTIME_DIR=/run/user/$(id -u)
      fi

      export STATUS_FILE="${statusFile}"

      enable_display() {
        printf "true" >"$STATUS_FILE"
        hyprctl dispatch dpms on
        brightnessctl -d ${kbLightID} s 100
        brightnessctl -d ${kbScreenOFFLightID} s 0
      }

      disable_display() {
        printf "false" >"$STATUS_FILE"
        hyprctl dispatch dpms off
        brightnessctl -d ${kbLightID} s 0
        brightnessctl -d ${kbScreenOFFLightID} s 100
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
    '')
  ];
}
