{ inputs, ... }:
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

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    inputs.nurpkgs.overlays.default
  ] ++ (builtins.attrValues (import ./overlays.nix { inherit inputs; }));
}
