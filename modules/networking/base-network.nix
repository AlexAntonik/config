{ host, lib, ... }:
{
  users.users.${host.username}.extraGroups = [ "networkmanager" ];
  services.resolved.enable = true;
  networking = {
    hostName = host.hostName;
    networkmanager = {
      enable = true;
      dns = lib.mkForce "none";
    };
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "9.9.9.9"
    ];
  };
}
