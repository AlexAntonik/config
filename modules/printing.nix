{ pkgs, host, ... }:
{
  users.users.${host.username}.extraGroups = [
    "lp"
    "scanner"
  ];
  hardware = {
    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
      disabledDefaultBackends = [ "escl" ];
    };
  };
  services = {
    printing = {
      enable = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
  };
}
