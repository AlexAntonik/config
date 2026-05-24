{ lib, pkgs }:
path:
let
  pathStr = toString path;
  name = builtins.replaceStrings [ "/" "." ] [ "-" "-" ] (baseNameOf pathStr);
in
pkgs.runCommandLocal name { } "ln -s ${lib.escapeShellArg pathStr} $out"
