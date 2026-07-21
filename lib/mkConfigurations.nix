{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  root = toString ./..;
  hosts = lib.filterAttrs (_: type: type == "directory") (builtins.readDir "${root}/hosts");
in
lib.genAttrs (builtins.attrNames hosts) (
  host:
  lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      "${root}/lib/lib.nix"
      "${root}/hosts/${host}/${host}.nix"
    ];
  }
)
