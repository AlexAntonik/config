{
  env,
  options,
  lib,
  ...
}:
{
  networking = {
    hostName = "${env.host}";
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
      ];
      # dns = "none"; # Prevent NetworkManager from managing DNS
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
