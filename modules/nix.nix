{ inputs, ... }: { host, ... }: {
  system.stateVersion = host.stateVersion;

  nixpkgs.config.allowUnfree = true;
  nix = {
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    optimise.automatic = true;
  };
  environment.shellAliases = {
    fr = "nh os switch --diff=always";
    fu = "nh os switch --update --diff=always";
    nhc = "nh clean all";
  };
  programs.nh = {
    enable = true;
    flake = host.flakePath;
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };
}