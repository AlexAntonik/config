{
  lib,
  config,
  ...
}:
{
  imports = [
  ];

  services.tlp.enable = lib.mkDefault (
    (lib.versionOlder (lib.versions.majorMinor lib.version) "21.05")
    || !config.services.power-profiles-daemon.enable
  );
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
