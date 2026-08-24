{ pkgs, lib, ... }:
{
  _module.args.mkOutOfStoreSymlink =
    path:
    let
      pathStr = toString path;
    in
    pkgs.runCommandLocal (lib.strings.sanitizeDerivationName (baseNameOf pathStr)) { } ''
      ln -s "${lib.escapeShellArg pathStr}" $out
    '';
}
