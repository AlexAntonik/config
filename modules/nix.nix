{ inputs, host, ... }:
{
  system.stateVersion = "${host.stateVersion}";
  nixpkgs.config.allowUnfree = true;
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
  environment.shellAliases = {
    fr = "nh os switch --hostname ${host.hostname} --diff=always";
    fu = "nh os switch --hostname ${host.hostname} --update --diff=always";
    change-host = "sh ${host.flakePath}/install.sh";
    ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
  };
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = host.flakePath;
  };
}
