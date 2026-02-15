{
  pkgs,
  username,
  ...
}:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/home/${username}/config";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor  # Pretty output for Nix builds
    nvd                 # Show differences between Nix derivations
  ];
}
