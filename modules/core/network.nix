{ pkgs, host, options, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    # Tryed setup wireguard vpn but unsuccessful
    # firewall = {
    #   checkReversePath = false; 
    #   # if packets are still dropped, they will show up in dmesg
    #   logReversePathDrops = true;
    #   # wireguard trips rpfilter up
    #   extraCommands = ''
    #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
    #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
    #   '';
    #   extraStopCommands = ''
    #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
    #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
    #   '';
    # };
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
