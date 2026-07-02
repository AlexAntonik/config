{ host, options, ... }:
{
  users.users.${host.username}.extraGroups = [
    "networkmanager"
  ];
  services.resolved.enable = true;
  networking = {
    hostName = "${host.hostname}";

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

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
