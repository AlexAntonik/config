{
  flake.nixosModules.printing =
    { pkgs, ... }:
    {
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
          drivers = [
            # pkgs.hplipWithPlugin
          ];
        };

        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
        ipp-usb.enable = true;
      };
    };
}
