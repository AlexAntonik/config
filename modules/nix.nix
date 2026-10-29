{ inputs, host, lib, ... }:
{
  system.stateVersion = host.stateVersion;

  nixpkgs.config.allowUnfree = true;
  nix = {
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "cgroups" # run each build in its own cgroup, so OOM killers can target a single build
      ];
      use-cgroups = true; # enable the cgroups feature above
    };
    optimise.automatic = true;

    # Run builds with lowest CPU and IO priority
    daemonIOSchedClass = lib.mkDefault "idle";
    daemonCPUSchedPolicy = lib.mkDefault "idle";
  };

  # Move nix-daemon out of system.slice: heavy builds then do not count
  # towards the oomd-monitored system.slice pressure, and oomd kills
  # the daemon's own cgroup instead of a system service
  systemd.services.nix-daemon.serviceConfig.Slice = "-.slice";
  environment.shellAliases = {
    fr = "nh os switch --diff=always";
    fu = "nh os switch --update --diff=always";
    nhc = "nh clean all";
    ns = "nix shell";
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
