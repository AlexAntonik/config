{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  hostsDir = ../hosts;
  hostNames = builtins.attrNames (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir hostsDir)
  );
in
lib.genAttrs hostNames (
  host:
  lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      hostName = host;
    };
    modules = [
      ./lib.nix
      (hostsDir + "/${host}/${host}.nix")
    ];
  }
)
