{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:danth/stylix/release-25.05";
    nurpkgs.url = "github:nix-community/NUR";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "alex";
      profile = "amd";
      username = "alex";
      commonSpecialArgs = {
        inherit inputs username host profile;
      };

      mkSystem = profileName: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = commonSpecialArgs;
        modules = [ ./profiles/${profileName} ];
      };
    in
    {
      overlays = import ./overlays.nix {inherit inputs;};
      nixosConfigurations = {
        amd = mkSystem "amd";
        nvidia = mkSystem "nvidia";
        nvidia-laptop = mkSystem "nvidia-laptop";
        intel = mkSystem "intel";
        vm = mkSystem "vm";
      };
    };
}
