{
  lib,
  staticArgs,
}:
modulePath:
let
  f = import modulePath;
  fArgs = builtins.functionArgs f;
  argNames = builtins.attrNames fArgs;
  requiredArgs = builtins.filter (name: !fArgs.${name}) argNames;
  applies =
    lib.isFunction f
    && builtins.any (name: builtins.elem name argNames) (builtins.attrNames staticArgs)
    && builtins.all (name: builtins.elem name (builtins.attrNames staticArgs)) requiredArgs;
in
{
  key = toString modulePath;
  _file = toString modulePath;
  imports = [ (if applies then f staticArgs else f) ];
}