{ lib }:
let
  # mkSymlinks "vscode" { "/home/user/.config/file" = "/nix/store/.../file"; }
  mkSymlinks = moduleName: symlinks:
    lib.mapAttrs' (target: source:
      let
        name = builtins.replaceStrings [ "/" "." ] [ "-" "-" ] target;
        scriptName = "${moduleName}-${name}";
      in
      lib.nameValuePair scriptName {
        text = ''
          mkdir -p "$(dirname ${lib.escapeShellArg target})"
          ln -sf ${lib.escapeShellArg source} ${lib.escapeShellArg target}
        '';
      }
    ) symlinks;
in {
  inherit mkSymlinks;
}
