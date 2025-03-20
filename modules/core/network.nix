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

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
    interfaces.wlp1s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;
    networking.wireless.powersave = false;
    networkmanager.enable = true;
    networkmanager.insertNameservers = [
      "1.1.1.1" # BEST
      "8.8.8.8" # Evil
      "9.9.9.9" # Just for fun
      "10.2.0.1" # ProtonVPN Wireguard DNS 
    ];

    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

     firewall.enable = false;
    firewall = {
      checkReversePath = "loose";
      # if packets are still dropped, they will show up in dmesg
      logReversePathDrops = true;
      # wireguard trips rpfilter up
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
