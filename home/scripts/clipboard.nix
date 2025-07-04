{
  pkgs,
  ...
}:
{
  home = {
    packages = [
      (pkgs.writeShellScriptBin "clipboard-manager" ''
        #!/usr/bin/env bash

        # Clipboard history manager with image preview support
        # Uses cliphist, rofi, and wl-clipboard for Wayland environments

        tmp_dir="/tmp/cliphist"
        rm -rf "$tmp_dir"

        # If argument provided, decode and copy directly
        if [[ -n "$1" ]]; then
            cliphist decode <<< "$1" | ${pkgs.wl-clipboard}/bin/wl-copy
            exit
        fi

        # Setup temporary directory for image files
        mkdir -p "$tmp_dir"
        chmod 755 "$tmp_dir"

        # AWK program to process clipboard entries
        read -r -d "" prog << "EOF"
        /^[0-9]+\s<meta http-equiv=/ { 
            next 
        }

        # Match images with size and resolution metadata
        match($0, /^([0-9]+)\s+\[\[\s*binary data\s+([0-9.]+)\s*(KiB|MiB|B)\s+(png|jpg|jpeg|bmp)\s+([0-9]+)x([0-9]+)/, grp) {
            img_path = tmp_dir "/" grp[1] "." grp[4]
            cmd = "echo " grp[1] " | tr -d '\\t\\n' | cliphist decode > \"" img_path "\" && chmod 644 \"" img_path "\""
            system(cmd)
            
            if (system("test -f \"" img_path "\"") == 0) {
                orig = $0
                # Replace display text but keep original line in orig variable
                display = "🖼️ " grp[2] grp[3] " • " grp[5] "×" grp[6]
                printf "%s\t\t\t\t\t%s\0icon\x1f%s\n", display, orig, img_path
            } else {
                print $0
            }
            next
        }

        # Match images without full metadata
        match($0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
            img_path = tmp_dir "/" grp[1] "." grp[3]
            cmd = "echo " grp[1] " | tr -d '\\t\\n' | cliphist decode > \"" img_path "\" && chmod 644 \"" img_path "\""
            system(cmd)
            
            if (system("test -f \"" img_path "\"") == 0) {
                orig = $0
                # Replace display text but keep original line in orig variable
                printf "🖼️ Image\t\t\t\t\t%s\0icon\x1f%s\n", orig, img_path
            } else {
                print $0
            }
            next
        }

        # For non-image entries, strip the leading number
        {
            if (match($0, /^[0-9]+\s+(.*)/, arr)) {
                print arr[1]
            } else {
                print
            }
        }
        EOF

        # Get selection from cliphist using rofi
        export tmp_dir
        selection=$(cliphist list | ${pkgs.gawk}/bin/gawk -v tmp_dir="$tmp_dir" "$prog" | ${pkgs.rofi-wayland}/bin/rofi -dmenu -i -p "Clipboard" -show-icons)

        # Exit if nothing was selected
        [ -z "$selection" ] && exit

        # Process different types of selections
        if [[ "$selection" =~ ^🖼️ ]]; then
            # Image entry - extract original line after tabs
            selection=$(echo "$selection" | sed -E 's/^[^\t]+\t+//')
        elif [[ ! "$selection" =~ ^\[[[:space:]]*binary[[:space:]]data ]] && [[ ! "$selection" =~ ^[0-9]+[[:space:]] ]]; then
            # Non-image entry without ID - find original entry with ID from cliphist
            orig_selection=$(cliphist list | grep -F -m1 "$selection")
            if [ -n "$orig_selection" ]; then
                selection=$orig_selection
            fi
        fi

        # Copy selection to clipboard and simulate paste
        cliphist decode <<< "$selection" | ${pkgs.wl-clipboard}/bin/wl-copy
        sleep 0.02  # Brief delay for clipboard sync
        ${pkgs.wtype}/bin/wtype -M ctrl -k v -m ctrl
      '')
    ];
  };
}
