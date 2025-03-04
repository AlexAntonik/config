{pkgs}:
pkgs.writeShellScriptBin "list-keybinds" ''
  # check if rofi is already running
  if pidof rofi > /dev/null; then
    pkill rofi
  fi

  msg='☣️ NOTE ☣️: Clicking with Mouse or Pressing ENTER will have NO function'
  keybinds=$(cat ~/.config/hypr/hyprland.conf | grep modifier)

  # use rofi to display the keybinds with the modified content
  echo "$keybinds" | rofi -dmenu -i -config ~/.config/rofi/config-long.rasi -mesg "$msg"

''
