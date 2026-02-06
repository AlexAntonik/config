{ pkgs }:
pkgs.writeShellScriptBin "noctalia-config" ''
     noctalia-shell ipc call state all \
  | jq -r '
    def nix:
      if type == "object" then
        "{\n" +
        (to_entries | map("  \(.key) = \(.value | nix);") | join("\n")) +
        "\n}"
      elif type == "array" then
        "[ " + (map(nix) | join(" ")) + " ]"
      elif type == "string" then
        @json
      elif type == "number" or type == "boolean" then
        tostring
      elif type == "null" then
        "null"
      else
        "\"unsupported\""
      end;
    .settings | nix
  ' | nixfmt
''
