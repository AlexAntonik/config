{ pkgs, config, ... }:
{
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    # required to connect to Tailscale exit nodes
    checkReversePath = "loose";
  };

  services.tailscale = {
    enable = true;
    package = pkgs.tailscale;
  };
  systemd.services.tailscale-operator = {
    description = "Set tailscale operator";
    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];
    wantedBy = [ "multi-user.target" ];
    path = [ config.services.tailscale.package ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = "tailscale set --operator=${config.host.username}";
  };
}
