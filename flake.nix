{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-25.05";
    nurpkgs.url = "github:nix-community/NUR";
  };

  outputs = inputs: {
    nixosConfigurations = builtins.listToAttrs (
      map (host: {
        name = host;
        value = inputs.nixpkgs.lib.nixosSystem {
          system = (import ./hosts/${host}/env.nix).system;
          specialArgs = {
            inherit inputs host;
            username = (import ./hosts/${host}/env.nix).username;
          };
          modules = [ ./hosts/${host}/config.nix ];
        };
      }) (builtins.attrNames (builtins.readDir ./hosts))
    );
  };
}
