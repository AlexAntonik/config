{ pkgs }:
pkgs.writeShellScriptBin "clipboard-manager" ''
  #!/usr/bin/env bash
  if [[ -n "$1" ]]; then
    cliphist decode <<< "$1" | ${pkgs.wl-clipboard}/bin/wl-copy
    exit
  fi

  CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/cliphist-thumbs"
  mkdir -p "$CACHE_DIR"

  while IFS= read -r line; do
    if [[ "$line" =~ ^([0-9]+)[[:space:]]+\[\[.*binary\ data.*(png|jpe?g|bmp) ]]; then
      id="''${BASH_REMATCH[1]}"
      thumb_path="$CACHE_DIR/$id.png"
      
      if [[ ! -f "$thumb_path" ]]; then
        cliphist decode <<< "$line" | ${pkgs.imagemagick}/bin/convert - -resize 128x128^ -gravity center -extent 128x128 "$thumb_path" 2>/dev/null || true
      fi
    fi
  done < <(cliphist list)

  read -r -d "" prog << EOF
  match(\$0, /^([0-9]+)\s+\[\[\s*binary data.*(png|jpe?g|bmp)/, g) {
    id = g[1]
    thumb_path = "$CACHE_DIR/" id ".png"
    printf "🖼️ Image\0icon\x1f%s\x1finfo\x1f%s\n", thumb_path, \$0
    next
  }
  match(\$0, /^[0-9]+\s+(.*)/, g) {
    printf "%s\0info\x1f%s\n", g[1], \$0
    next
  }
EOF

  selection=$(
    cliphist list |
    ${pkgs.gawk}/bin/gawk "$prog" |
    ${pkgs.rofi}/bin/rofi -dmenu -i -p "Clipboard" -format 'i s' -show-icons
  )

  [ -z "$selection" ] && exit
  index=$(echo "$selection" | awk '{print $1}')
  orig=$(cliphist list | sed -n "$((index+1))p")
  cliphist decode <<< "$orig" | ${pkgs.wl-clipboard}/bin/wl-copy
  sleep 0.02
  ${pkgs.wtype}/bin/wtype -M ctrl -k v -m ctrl
''