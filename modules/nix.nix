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
  nixpkgs.config.allowUnfree = true;
}
