{
  pkgs,
  host,
  options,
  lib,
  ...
}:
{
  networking = {
    hostName = "${host}";
    # avoid checking if IP is already taken to boot a few seconds faster
    dhcpcd.extraConfig = "noarp";
    # no need to wait interfaces to have an IP to continue booting
    dhcpcd.wait = "background";
    useDHCP = lib.mkDefault true;

    networkmanager = {
      wifi.powersave = false;
      enable = true;
      insertNameservers = [
        "1.1.1.1" # BEST
        "8.8.8.8" # Evil
        "9.9.9.9" # Just for fun
        "10.2.0.1" # ProtonVPN Wireguard DNS
      ];
      # dns = "none"; # Prevent NetworkManager from managing DNS
    };

    # Make system-wide DNS settings
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "9.9.9.9"
      "10.2.0.1"
    ];

    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

    # firewall.enable = false;
    firewall = {
      checkReversePath = "loose";
      # if packets are still dropped, they will show up in dmesg
      # logReversePathDrops = true;
      # wireguard trips rpfilter up
      trustedInterfaces = [ "proton0" ];
      extraCommands = ''
        iptables -A nixos-fw -i proton0 -j ACCEPT
        ip6tables -A nixos-fw -i proton0 -j ACCEPT

        iptables -A OUTPUT -o proton0 -j ACCEPT
        ip6tables -A OUTPUT -o proton0 -j ACCEPT

        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        iptables -D nixos-fw -i proton0 -j ACCEPT || true
        ip6tables -D nixos-fw -i proton0 -j ACCEPT || true
        iptables -D OUTPUT -o proton0 -j ACCEPT || true
        ip6tables -D OUTPUT -o proton0 -j ACCEPT || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
