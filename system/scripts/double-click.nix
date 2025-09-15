{pkgs}:
pkgs.writeShellScriptBin "double-click" ''
  DELAY=0.4
  [ $# -eq 0 ] && { echo "Usage: $0 command"; exit 1; }
  
  COMMAND="$*"
  COMMAND_HASH=$(printf '%s' "$*" | ${pkgs.coreutils}/bin/md5sum | cut -d' ' -f1)
  LAST_PRESS_FILE="/tmp/double_press_''${COMMAND_HASH}"
  current_time=$(${pkgs.coreutils}/bin/date +%s.%N)
  
  if [[ -f "$LAST_PRESS_FILE" ]]; then
    last_time=$(cat "$LAST_PRESS_FILE")
    time_diff=$(echo "$current_time - $last_time" | ${pkgs.bc}/bin/bc)
    
    if (( $(echo "$time_diff < $DELAY" | ${pkgs.bc}/bin/bc -l) )); then
      exec "$@"
      rm "$LAST_PRESS_FILE"
      exit 0
    fi
  fi
  
  echo "$current_time" > "$LAST_PRESS_FILE"
''