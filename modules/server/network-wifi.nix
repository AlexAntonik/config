{ host, options, ... }:
{
  users.users.${host.username}.extraGroups = [
    "networkmanager"
  ];
  networking = {
    hostName = "${host.hostname}";
    # avoid checking if IP is already taken to boot a few seconds faster
    dhcpcd.extraConfig = "noarp";
    # no need to wait interfaces to have an IP to continue booting
    dhcpcd.wait = "background";

    networkmanager = {
      wifi.powersave = false;
      enable = true;
      dns = "systemd-resolved";
    };

    # Make system-wide DNS settings
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "9.9.9.9"
    ];
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  };
}
