{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin
    "screenshot"
    ''
      export PATH=${
        pkgs.lib.makeBinPath [
          pkgs.hyprshot
          pkgs.satty
          pkgs.slurp
          pkgs.wl-clipboard
          pkgs.libnotify
          pkgs.coreutils
          pkgs.procps
        ]
      }:$PATH

      OUTPUT_DIR="$HOME/Pictures/Screenshots"

      if [[ ! -d "$OUTPUT_DIR" ]]; then
        mkdir -p "$OUTPUT_DIR"
        if [[ ! -d "$OUTPUT_DIR" ]]; then
          notify-send "Failed to create screenshot directory: $OUTPUT_DIR" -u critical -t 3000
          exit 1
        fi
      fi

      pkill slurp || hyprshot -m ''${1:-region} --raw | \
        satty --filename - \
          --output-filename "$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
          --early-exit \
          --action-on-enter save-to-clipboard \
          --save-after-copy \
          --copy-command 'wl-copy' \
          --disable-notifications
    '')
  ];
}