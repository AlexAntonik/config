{
  lib,
  config,
  ...
}:
{
  services.tlp.enable = lib.mkDefault (!config.services.power-profiles-daemon.enable);
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia = {
  #   prime = {
  #     offload = {
  #       enable = true;
  #       enableOffloadCmd = true;
  #     };
  #     # Make sure to use the correct Bus ID values for your system!
  #     intelBusId = "PCI:1:0:0";
  #     nvidiaBusId = "PCI:0:2:0";
  #   };
  # };

}
