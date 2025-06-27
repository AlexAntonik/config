{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:danth/stylix/release-25.05";
    nurpkgs.url = "github:nix-community/NUR";
  };

  outputs =
    inputs:
    let
      inherit (import ./local.nix) system host username;
      specialArgs = { inherit inputs username host; };
    in
    {
      nixosConfigurations.${host} = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgs;
        modules = [ ./hosts/${host} ];
      };
    };
}
