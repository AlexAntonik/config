{ pkgs }:
pkgs.writeShellScriptBin "clipboard-manager" ''
  #!/usr/bin/env bash

  if [[ -n "$1" ]]; then
      cliphist decode <<< "$1" | ${pkgs.wl-clipboard}/bin/wl-copy
      exit
  fi

  read -r -d "" prog << 'EOF'
  # Изображения — только пометка
  match($0, /^([0-9]+)\s+\[\[\s*binary data.*(png|jpe?g|bmp)/, g) {
      printf "🖼️ Image id %s\0info\x1f%s\n", g[1], $0
      next
  }
  # Текст — выводим сам текст, а в info кладём оригинал
  match($0, /^[0-9]+\s+(.*)/, g) {
      printf "%s\0info\x1f%s\n", g[1], $0
      next
  }
  EOF

  selection=$(
    cliphist list |
    ${pkgs.gawk}/bin/gawk "$prog" |
    ${pkgs.rofi-wayland}/bin/rofi -dmenu -i -p "Clipboard" -format 'i s'
  )

  [ -z "$selection" ] && exit

  index=$(echo "$selection" | awk '{print $1}')
  orig=$(cliphist list | sed -n "$((index+1))p")

  cliphist decode <<< "$orig" | ${pkgs.wl-clipboard}/bin/wl-copy
  sleep 0.02
  ${pkgs.wtype}/bin/wtype -M ctrl -k v -m ctrl
''
