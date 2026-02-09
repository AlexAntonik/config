{
  pkgs,
  host,
  options,
  lib,
  ...
}:
{
  services.resolved.enable = true;
  networking = {
    hostName = "${host}";
    useDHCP = lib.mkDefault true;

    networkmanager = {
      wifi.powersave = false;
      enable = true;
      dns = "systemd-resolved";
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
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
