{ pkgs, host, ... }:
let
  backlightDaemon = pkgs.writeShellScriptBin "backlight-daemon" ''
    export PATH="${pkgs.brightnessctl}/bin:$PATH"

    LAST_STATUS=""

    while true; do
      if IFS= read -r CURRENT_STATUS < "/sys/class/drm/card1-${host.mainMonitor}/enabled" 2>/dev/null; then
        DRM_STATUS="$CURRENT_STATUS"
      else
        DRM_STATUS="unknown"
      fi

      if [ "$DRM_STATUS" != "$LAST_STATUS" ]; then
        if [ "$DRM_STATUS" = "disabled" ]; then
          brightnessctl -d "${host.keyboardLightID}" s 0
          brightnessctl -d "${host.keyboardScreenOFFLightID}" s 100
        else
          brightnessctl -d "${host.keyboardLightID}" s 3
          brightnessctl -d "${host.keyboardScreenOFFLightID}" s 0
        fi
        LAST_STATUS="$DRM_STATUS"
      fi

      sleep 1
    done
  '';
in
{
  systemd.services.backlight-deamon = {
    description = "Daemon to check DRM display status and toggle keyboard LED";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${backlightDaemon}/bin/backlight-daemon";
      Restart = "always";
      RestartSec = "5sec";
    };
  };
}