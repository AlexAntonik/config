{ host, pkgs, ... }:
let
  inherit (import ../hosts/${host}/env.nix)
    languageLightID;

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

    check_layout() {
      current_layout=$(hyprctl devices -j | ${pkgs.jq}/bin/jq -r '.keyboards[] | select(.main == true) | .active_keymap')
      case "$current_layout" in
        *"Russian"*|*"ru"*|*"RU"*|*"русский"*|*"Русский"*)
          brightnessctl -d ${languageLightID} s 100
          ;;
        *)
          brightnessctl -d ${languageLightID} s 0
          ;;
      esac
    }

    wait_for_socket
    check_layout

    ${pkgs.socat}/bin/socat -U - UNIX-CONNECT:"$SOCKET" | while read -r line; do
      if [[ "$line" == activelayout* ]]; then
        check_layout
      fi
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

    serviceConfig = {
      Type = "simple";
      ExecStart = "${keyboard-layout-indicator}/bin/keyboard-layout-indicator";
      ExecStop = "/bin/kill $MAINPID";
      KillMode = "process";
      Restart = "always";
      RestartSec = "3";
      TimeoutStopSec = 5;
      Environment = [
        "PATH=${pkgs.hyprland}/bin:${pkgs.brightnessctl}/bin:${pkgs.jq}/bin:${pkgs.socat}/bin:$PATH"
      ];
    };
  };
}
