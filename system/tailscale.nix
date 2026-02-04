{
  flake.nixosModules.tailscale =
    { pkgs, ... }:
    {
      networking.firewall = {
        trustedInterfaces = [ "tailscale0" ];
        # required to connect to Tailscale exit nodes
        checkReversePath = "loose";
      };
      services.tailscale = {
        enable = true;
        package = pkgs.unstable.tailscale;
      };
    };
}
