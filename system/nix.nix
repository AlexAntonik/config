{
  flake.nixosModules.nix =
    {
      inputs,
      ...
    }:
    {
      nix = {
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
        settings = {
          max-jobs = 2;
          download-buffer-size = 500000000;
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          substituters = [ "https://hyprland.cachix.org" ];
          trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        };
      };

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          inputs.nix-vscode-extensions.overlays.default

          # Inline overlay for unstable packages
          (final: prev: {
            unstable = import inputs.unstable {
              system = final.stdenv.hostPlatform.system;
              config.allowUnfree = true;
            };
          })
        ];
      };
    };
}
