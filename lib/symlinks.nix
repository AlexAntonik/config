{ lib }:
let
  mkActivation = moduleName: scripts:
    lib.mapAttrs' (name: value:
      lib.nameValuePair "${moduleName}-${name}" (
        if builtins.isString value then { text = value; } else value
      )
    ) scripts;

  # mkSymlinks "vscode" host { ".config/Code/User/settings.json" = "modules/vscode/settings.json"; }
  # creates { vscode-.config-Code-User-settings.json = { text = "ln -sf ..."; }; }
  mkSymlinks = moduleName: host: symlinks:
    let
      userHome = "/home/${host.username}";
      flakeRoot = host.flakePath;
    in
    mkActivation moduleName (lib.mapAttrs' (targetRel: sourceRel:
      let
        name = builtins.replaceStrings [ "/" "." ] [ "-" "-" ] targetRel;
        target = "${userHome}/${targetRel}";
        source = "${flakeRoot}/${sourceRel}";
      in
      lib.nameValuePair name ''
        mkdir -p "$(dirname ${lib.escapeShellArg target})"
        ln -sf ${lib.escapeShellArg source} ${lib.escapeShellArg target}
      ''
    ) symlinks);
in {
  inherit mkSymlinks;
}
