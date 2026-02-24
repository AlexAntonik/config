{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin
    "toggle_xwayland_scale"
    ''
      if [ -z "$XDG_RUNTIME_DIR" ]; then
        export XDG_RUNTIME_DIR=/run/user/$(id -u)
      fi

      export STATUS_FILE="$XDG_RUNTIME_DIR/xwayland_scale.status"

      enable_scaling() {
        printf "true" >"$STATUS_FILE"
        hyprctl keyword xwayland:force_zero_scaling true
        noctalia-shell ipc call toast send '{"title": "Touchpad", "body": "XWayland Force Scale ON", "icon": "zoom"}'
      }

      disable_scaling() {
        printf "false" >"$STATUS_FILE"
        hyprctl keyword xwayland:force_zero_scaling false
        noctalia-shell ipc call toast send '{"title": "Touchpad", "body": "XWayland Force Scale OFF", "icon": "zoom-cancel"}'
      }

      if ! [ -f "$STATUS_FILE" ]; then
        enable_scaling
      else
        if [ $(cat "$STATUS_FILE") = "true" ]; then
          disable_scaling
        elif [ $(cat "$STATUS_FILE") = "false" ]; then
          enable_scaling
        fi
      fi
    '')
  ];
}
