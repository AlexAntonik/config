{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.kbdBacklight;

  kbdIdleScript = pkgs.writeShellScript "kbd-backlight-idle" ''
    state_file="/run/user/$(id -u)/kbd-backlight-state.kbd"

    ${pkgs.swayidle}/bin/swayidle -w \
      timeout ${cfg.idleTimeout} \
        "${pkgs.brightnessctl}/bin/brightnessctl -d ${cfg.keyboardLightID} g > \"$state_file\"; \
         ${pkgs.brightnessctl}/bin/brightnessctl -d ${cfg.keyboardLightID} s 0" \
      resume \
        "current=\$(${pkgs.brightnessctl}/bin/brightnessctl -d ${cfg.keyboardLightID} g); \
         if [ \"\$current\" -eq 0 ]; then \
           [ -f \"$state_file\" ] && \
           ${pkgs.brightnessctl}/bin/brightnessctl -d ${cfg.keyboardLightID} s \$(cat \"$state_file\"); \
         else \
           echo \"\$current\" > \"$state_file\"; \
         fi"
  '';

  backlightDaemon = pkgs.writeShellScriptBin "backlight-daemon" ''
    export PATH="${pkgs.brightnessctl}/bin:$PATH"

    DRM_PATH=$(echo /sys/class/drm/card*-${cfg.mainMonitor}/enabled 2>/dev/null)
    LAST_STATUS=""

    while true; do
      if IFS= read -r CURRENT_STATUS < "$DRM_PATH" 2>/dev/null; then
        DRM_STATUS="$CURRENT_STATUS"
      else
        DRM_STATUS="unknown"
      fi

      if [ "$DRM_STATUS" != "$LAST_STATUS" ]; then
        if [ "$DRM_STATUS" = "disabled" ]; then
          brightnessctl -d "${cfg.keyboardLightID}" s 0
          brightnessctl -d "${cfg.screenOffLightID}" s 100
        else
          brightnessctl -d "${cfg.keyboardLightID}" s 3
          brightnessctl -d "${cfg.screenOffLightID}" s 0
        fi
        LAST_STATUS="$DRM_STATUS"
      fi

      sleep 1
    done
  '';
in
{
  options.services.kbdBacklight = {
    enable = lib.mkEnableOption "keyboard backlight idle and screen-off automation";

    idleTimeout = lib.mkOption {
      type = lib.types.str;
      default = "120";
      description = "Seconds of input idle before the keyboard backlight is switched off";
    };

    keyboardLightID = lib.mkOption {
      type = lib.types.str;
      description = "brightnessctl device name of the keyboard backlight";
    };

    mainMonitor = lib.mkOption {
      type = lib.types.str;
      description = "DRM connector suffix of the main monitor, e.g. eDP-1";
    };

    screenOffLightID = lib.mkOption {
      type = lib.types.str;
      description = "brightnessctl device name lit while the main screen is off";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.kbd-backlight-idle = {
      description = "Turn off keyboard backlight and light indicator LED after idle";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${kbdIdleScript}";
        Restart = "always";
        RestartSec = "5sec";
        Nice = 19;
        Type = "simple";
      };
    };

    systemd.services.backlight-daemon = {
      description = "Daemon to check DRM display status and toggle keyboard LED";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${backlightDaemon}/bin/backlight-daemon";
        Restart = "always";
        RestartSec = "5sec";
      };
    };
  };
}
