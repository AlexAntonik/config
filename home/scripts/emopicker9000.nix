{ pkgs }:
pkgs.writeShellScriptBin "emopicker9000" ''
  # check if rofi is already running
  if pidof rofi > /dev/null; then
    pkill rofi
  fi

  # Get user selection via wofi from emoji file.
  chosen=$(cat $HOME/.config/.emoji | ${pkgs.rofi-wayland}/bin/rofi -i -dmenu  | awk '{print $1}')

  # Exit if none chosen.
  [ -z "$chosen" ] && exit

  # If you run this command with an argument, it will automatically insert the
  # character. Otherwise, show a message that the emoji has been copied.
  if [ -n "$1" ]; then
   ${pkgs.ydotool}/bin/ydotool type "$chosen"
  else
      printf "$chosen" | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.wtype}/bin/wtype -M ctrl -k v -m ctrl
  fi
''
