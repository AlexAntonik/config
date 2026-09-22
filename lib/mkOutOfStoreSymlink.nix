{
  pkgs,
  lib,
  inputs,
  host,
  ...
}:
{
  _module.args.mkOutOfStoreSymlink =
    path:
    let
      sourceRoot = toString inputs.self + "/";
      pathStr = toString path;
      target = "${host.flakePath}/${lib.removePrefix sourceRoot pathStr}";
      valid = lib.hasPrefix sourceRoot pathStr && builtins.pathExists path;
    in
    lib.throwIfNot valid
      "mkOutOfStoreSymlink: argument must be an existing file inside this flake source (${sourceRoot}), got: ${pathStr}"
      pkgs.runCommandLocal (lib.strings.sanitizeDerivationName (baseNameOf pathStr)) { } ''
      ln -s ${lib.escapeShellArg target} $out
    '';
}
