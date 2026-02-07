{ lib, ... }:
{
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    hostName = "swprod";
    domain = "";
    nameservers = [
      "8.8.8.8"
    ];
    defaultGateway = "178.128.160.1";
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          {
            address = "178.128.166.97";
            prefixLength = 20;
          }
          {
            address = "10.16.0.5";
            prefixLength = 16;
          }
        ];
        ipv6.addresses = [
          {
            address = "fe80::cc9:c9ff:feb2:f5cc";
            prefixLength = 64;
          }
        ];
        ipv4.routes = [
          {
            address = "178.128.160.1";
            prefixLength = 32;
          }
        ];
        ipv6.routes = [
          {
            address = "";
            prefixLength = 128;
          }
        ];
      };
      eth1 = {
        ipv4.addresses = [
          {
            address = "10.106.0.2";
            prefixLength = 20;
          }
        ];
        ipv6.addresses = [
          {
            address = "fe80::8055:3dff:fe97:803f";
            prefixLength = 64;
          }
        ];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="0e:c9:c9:b2:f5:cc", NAME="eth0"
    ATTR{address}=="82:55:3d:97:80:3f", NAME="eth1"
  '';
}
