{ lib }:
let
  # Less reproducible than hm, but more useful for faster iteration. Use with care. 
  # mkSymlinks "vscode" {
  #   "/home/alex/.config/Code/User/settings.json" = ".../settings.json";
  #   "/etc/foo.conf" = ".../foo.conf";
  # }
  mkSymlinks =
    moduleName: symlinks:
    let
      manifest = "/var/lib/mkSymlinks/${moduleName}.list";
      entries = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (t: s: "${t}\t${s}") symlinks
      );
    in
    {
      "${moduleName}-symlinks" = {
        deps = [ "users" ];
        text = ''
          set -eu
          old=${lib.escapeShellArg manifest}
          mkdir -p "$(dirname "$old")"
          new=$(mktemp)
          cat > "$new" <<'MANIFEST'
          ${entries}
          MANIFEST

          # remove symlinks that were in the old manifest but are gone from config
          [ -f "$old" ] && comm -23 <(cut -f1 "$old" | sort) <(cut -f1 "$new" | sort) \
            | while read -r t; do
                [ -L "$t" ] && rm -f "$t"
              done

          # create or update current symlinks
          while IFS=$'\t' read -r target source; do
            [ -z "$target" ] && continue
            if [[ "$target" == /home/*/* ]]; then
              user=$(cut -d/ -f3 <<< "$target")
              runuser -u "$user" -- mkdir -p "$(dirname "$target")"
              runuser -u "$user" -- ln -sfn "$source" "$target"
            else
              mkdir -p "$(dirname "$target")"
              ln -sfn "$source" "$target"
            fi
          done < "$new"

          mv "$new" "$old"
        '';
      };
    };
in
mkSymlinks
