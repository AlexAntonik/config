{ inputs, host, ... }:
{
  system.stateVersion = host.stateVersion;
  hm.${host.username}.home.stateVersion = host.stateVersion;

  nixpkgs.config.allowUnfree = true;
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      download-buffer-size = 500000000;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    optimise.automatic = true;
  };
  environment.shellAliases = {
    fr = "nh os switch --hostname ${host.hostName} --diff=always";
    fu = "nh os switch --hostname ${host.hostName} --update --diff=always";
    nhc = "nh clean all";
    change-host = "sh ${host.flakePath}/install.sh";
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
