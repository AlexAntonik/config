{ lib }:
let
  # mkSymlinks "vscode" {
  #   "/home/alex/.config/Code/User/settings.json" = ".../settings.json";
  #   "/etc/foo.conf" = ".../foo.conf";
  # }
  # Paths under /home/<user>/ run as that user; everything else as root.
  homeUser =
    target:
    let
      m = builtins.match "/home/([^/]+)/.*" target;
    in
    if m == null then null else builtins.head m;

  mkSymlinks =
    moduleName: symlinks:
    lib.mapAttrs' (
      target: source:
      let
        name = builtins.replaceStrings [ "/" "." ] [ "-" "-" ] target;
        user = homeUser target;
        q = lib.escapeShellArg;
      in
      lib.nameValuePair "${moduleName}-${name}" {
        deps = [ "users" ];
        text =
          if user == null then
            ''
              mkdir -p "$(dirname ${q target})"
              ln -sfn ${q source} ${q target}
            ''
          else
            ''
              runuser -u ${q user} -- mkdir -p "$(dirname ${q target})"
              runuser -u ${q user} -- ln -sfn ${q source} ${q target}
            '';
      }
    ) symlinks;
in
mkSymlinks
