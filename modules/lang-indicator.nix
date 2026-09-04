{ languageLightID }:
{ pkgs, ... }:
let
  keyboard-layout-indicator = pkgs.writeShellScriptBin "keyboard-layout-indicator" ''
    set -e

    if [ -z "$XDG_RUNTIME_DIR" ]; then
      export XDG_RUNTIME_DIR=/run/user/$(id -u)
    fi

    SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

    wait_for_socket() {
      while [ ! -S "$SOCKET" ]; do
        sleep 1
      done
    }

    set_light() {
      case "$1" in
        *"English"*|*"english"*)
          brightnessctl -d ${languageLightID} s 0
          ;;
        *)
          brightnessctl -d ${languageLightID} s 100
          ;;
      esac
    }
    check_layout() {
      current_layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')
      set_light "$current_layout"
    }
    wait_for_socket
    MAIN_KBD=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .name')
    check_layout

    socat -U - UNIX-CONNECT:"$SOCKET" | while read -r line; do
      case "$line" in
        "activelayout>>"*)
          event_kbd="''${line#activelayout>>}"
          event_kbd="''${event_kbd%%,*}"
          if [ "$event_kbd" = "$MAIN_KBD" ]; then
            set_light "''${line#*,}"
          fi
          ;;
      esac
    done
  '';
in
{
  environment.systemPackages = [ keyboard-layout-indicator ];

  systemd.user.services.keyboard-layout-indicator = {
    description = "Keyboard Layout Indicator for Hyprland";
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    path = with pkgs; [
      hyprland
      brightnessctl
      jq
      socat
      coreutils
    ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${keyboard-layout-indicator}/bin/keyboard-layout-indicator";
      Restart = "always";
      RestartSec = "3";
      TimeoutStopSec = 5;
    };
  };
}
