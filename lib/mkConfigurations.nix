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
  let
    withArgs = import ./importApplyWithArgs.nix {
      inherit lib;
      staticArgs = { inherit inputs hostName; };
    };
  in
  lib.nixosSystem {
    modules = map withArgs [
      ./host.nix
      ./home-manager.nix
      ./mkOutOfStoreSymlink.nix
      (hostsDir + "/${hostName}/${hostName}.nix")
    ];
  }
)