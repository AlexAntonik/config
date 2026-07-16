{ lib }:
let
  # mkSymlinks "vscode" { "/home/user/.config/file" = "/path/to/file"; }
  # Runs as the home owner so links/dirs are not root-owned.
  mkSymlinks =
    moduleName: symlinks:
    lib.mapAttrs' (
      target: source:
      let
        name = builtins.replaceStrings [ "/" "." ] [ "-" "-" ] target;
        scriptName = "${moduleName}-${name}";
        user =
          let
            m = builtins.match "/home/([^/]+)/.*" target;
          in
          if m == null then null else builtins.head m;
      in
      lib.nameValuePair scriptName {
        deps = [ "users" ];
        text =
          if user == null then
            ''
              mkdir -p "$(dirname ${lib.escapeShellArg target})"
              ln -sfn ${lib.escapeShellArg source} ${lib.escapeShellArg target}
            ''
          else
            ''
              runuser -u ${lib.escapeShellArg user} -- mkdir -p "$(dirname ${lib.escapeShellArg target})"
              runuser -u ${lib.escapeShellArg user} -- ln -sfn ${lib.escapeShellArg source} ${lib.escapeShellArg target}
            '';
      }
    ) symlinks;
in
{
  inherit mkSymlinks;
}
