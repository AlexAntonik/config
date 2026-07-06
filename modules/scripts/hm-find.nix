{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin
    "hm-find"
    ''
      FILES=$(journalctl --since "-300m" -xe | grep hm-activate | awk -F "'|'" '/would be clobbered by backing up/ {print $2}')

      if [ -z "$FILES" ]; then
          echo "No conflicting backup files found."
          exit 0
      fi

      echo "The following backup files are preventing Home Manager from rebuilding:"
      echo "$FILES" | tr ' ' '\n'

      read -p "Do you want to remove these files? (y/N): " confirm

      if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
          echo "Deleting files..."
          echo "$FILES" | xargs rm -v
          echo "Cleanup completed at $(date)"
      else
          echo "No files were removed."
      fi
    '')
  ];
}
