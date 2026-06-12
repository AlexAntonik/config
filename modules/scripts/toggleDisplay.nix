{ pkgs,  ...}:
let
  statusFile = "$XDG_RUNTIME_DIR/display.status";
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

      if ! [ -f "$STATUS_FILE" ]; then
        printf "true" >"$STATUS_FILE"
        hyprctl dispatch dpms on
      else
        if [ $(cat "$STATUS_FILE") = "true" ]; then
          printf "false" >"$STATUS_FILE"
          hyprctl dispatch dpms off
        elif [ $(cat "$STATUS_FILE") = "false" ]; then
          printf "true" >"$STATUS_FILE"
          hyprctl dispatch dpms on
        fi
      fi
    '')
  ];
}
