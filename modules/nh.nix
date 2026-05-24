{ pkgs, host, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = host.flakePath;
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor # Pretty output for Nix builds
  ];
}
