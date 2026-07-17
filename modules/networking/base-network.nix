{ host, ... }:
{
  users.users.${host.username}.extraGroups = [ "networkmanager" ];
  services.resolved.enable = true;
  networking = {
    hostName = host.hostname;
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "9.9.9.9"
    ];
  };
}
