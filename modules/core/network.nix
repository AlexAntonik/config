{ pkgs, host, options, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    wireguard.enable = true;
    iproute2.enable = true;
    firewall = {
      enable = true;
      checkReversePath = "loose";
      allowedTCPPorts = [
        22    # SSH
        80    # HTTP
        443   # HTTPS
        1194  # OpenVPN
        4500  # IKE NAT-Traversal
        500   # ISAKMP/IKE
     #   59010
     #   59011
      ];
      allowedUDPPorts = [
        1194  # OpenVPN
        4500  # IKE NAT-Traversal
        500   # ISAKMP/IKE
        51820 # WireGuard
     #   59010
     #   59011
      ];
      extraCommands = ''
        iptables -A INPUT -p udp -m udp --dport 1194 -j ACCEPT
        iptables -A INPUT -p tcp -m tcp --dport 1194 -j ACCEPT
        iptables -A INPUT -i tun+ -j ACCEPT
        iptables -A FORWARD -i tun+ -j ACCEPT
        iptables -A FORWARD -o tun+ -j ACCEPT
        iptables -t nat -A POSTROUTING -o tun+ -j MASQUERADE
      '';
      #TODO vpn bad perfoming with firewall on
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
