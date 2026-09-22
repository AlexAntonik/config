{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  hostsDir = ../hosts;
  hostNames = builtins.attrNames (
    lib.filterAttrs (
      name: type:
      type == "directory" && !builtins.pathExists (hostsDir + "/${name}/.template")
    ) (builtins.readDir hostsDir)
  );
in
lib.genAttrs hostNames (
  hostName:
  lib.nixosSystem {
    specialArgs = { inherit hostName inputs; };
    modules = [
      ./host.nix
      ./home-manager.nix
      ./mkOutOfStoreSymlink.nix
      (hostsDir + "/${hostName}/${hostName}.nix")
    ];
  }
)
