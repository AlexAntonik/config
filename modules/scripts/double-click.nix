{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin
    "double-click"
    ''
      DELAY=0.4
      [ $# -eq 0 ] && { echo "Usage: $0 command"; exit 1; }

      COMMAND="$*"
      COMMAND_HASH=$(printf '%s' "$*" | ${coreutils}/bin/md5sum | cut -d' ' -f1)
      LAST_PRESS_FILE="/tmp/double_press_''${COMMAND_HASH}"
      current_time=$(${coreutils}/bin/date +%s.%N)

      if [[ -f "$LAST_PRESS_FILE" ]]; then
        last_time=$(cat "$LAST_PRESS_FILE")
        time_diff=$(echo "$current_time - $last_time" | ${bc}/bin/bc)
        
        if (( $(echo "$time_diff < $DELAY" | ${bc}/bin/bc -l) )); then
          rm "$LAST_PRESS_FILE"
          exec "$@"
          exit 0
        fi
      fi

      echo "$current_time" > "$LAST_PRESS_FILE"
    '')
  ];
}
