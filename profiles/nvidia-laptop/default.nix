{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) intelID nvidiaID;
in
{
  imports = [
    ../../hosts/${host}
    ../../drivers
    ../../core
  ];
  # Enable GPU Drivers
  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = true;
    intelBusID = "${intelID}";
    nvidiaBusID = "${nvidiaID}";
  };
  drivers.intel.enable = false;
  vm.guest-services.enable = false;
}
