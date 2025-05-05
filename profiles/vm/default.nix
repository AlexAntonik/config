{ host, ... }:
{
  imports = [
    ../../hosts/${host}
    ../../drivers
    ../../core
  ];
  # Enable GPU Drivers
  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = false;
  drivers.nvidia-prime.enable = false;
  drivers.intel.enable = false;
  vm.guest-services.enable = true;
}
