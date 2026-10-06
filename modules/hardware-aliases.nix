{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.hardwareAliases;
in
{
  options.services.hardwareAliases = {
    enable = lib.mkEnableOption "hardware toggle alias scripts (keyboard backlight, screen, touchpad)";

    keyboardLightID = lib.mkOption {
      type = lib.types.str;
      description = "brightnessctl device name of the keyboard backlight";
    };

    screenOffLightID = lib.mkOption {
      type = lib.types.str;
      description = "brightnessctl device name lit while the screen is off";
    };

    touchpadDeviceID = lib.mkOption {
      type = lib.types.str;
      description = "libinput device identifier as shown by hyprctl devices";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "kbd_backlight_off" ''
        KBD="${cfg.keyboardLightID}"

        if [ -z "$XDG_RUNTIME_DIR" ]; then
          export XDG_RUNTIME_DIR=/run/user/$(id -u)
        fi

        export LEVEL_FILE="$XDG_RUNTIME_DIR/kbd-backlight.level"

        current=$(brightnessctl -d "$KBD" g)

        if [ "$current" -gt 0 ]; then
          printf "%s" "$current" >"$LEVEL_FILE"
          brightnessctl -d "$KBD" s 0
        fi
      '')

      (pkgs.writeShellScriptBin "kbd_backlight_on" ''
        KBD="${cfg.keyboardLightID}"

        if [ -z "$XDG_RUNTIME_DIR" ]; then
          export XDG_RUNTIME_DIR=/run/user/$(id -u)
        fi

        export LEVEL_FILE="$XDG_RUNTIME_DIR/kbd-backlight.level"

        current=$(brightnessctl -d "$KBD" g)

        if [ "$current" -eq 0 ]; then
          if [ -f "$LEVEL_FILE" ]; then
            saved=$(cat "$LEVEL_FILE")
          else
            saved=3
          fi
          brightnessctl -d "$KBD" s "$saved"
        fi
      '')

      (pkgs.writeShellScriptBin "screen_off" ''
        brightnessctl -d "${cfg.screenOffLightID}" s 100
        noctalia msg dpms-off
      '')

      (pkgs.writeShellScriptBin "screen_on" ''
        brightnessctl -d "${cfg.screenOffLightID}" s 0
        noctalia msg dpms-on
      '')

      (pkgs.writeShellScriptBin "toggle_touchpad" ''
        HYPRLAND_DEVICE="${cfg.touchpadDeviceID}"

        if [ -z "$XDG_RUNTIME_DIR" ]; then
          export XDG_RUNTIME_DIR=/run/user/$(id -u)
        fi

        export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

        enable_touchpad() {
            printf "true" >"$STATUS_FILE"
            notify-send -i input-touchpad-on "Touchpad Enabled"
            hyprctl eval "hl.device({name = \"$HYPRLAND_DEVICE\", enabled = true })"
        }

        disable_touchpad() {
            printf "false" >"$STATUS_FILE"
            notify-send -i input-touchpad-off "Touchpad Disabled"
            hyprctl eval "hl.device({name = \"$HYPRLAND_DEVICE\", enabled = false })"
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
  };
}