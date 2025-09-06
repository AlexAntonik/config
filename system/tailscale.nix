{ pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };
}
