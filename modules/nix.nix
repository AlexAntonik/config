{
  inputs,
  stateVersion,
  ...
}:
{
  system.stateVersion = "${stateVersion}";
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
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      # Inline overlay for unstable packages
      (final: prev: {
        unstable = import inputs.unstable {
          system = final.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
      })
    ];
  };

}
