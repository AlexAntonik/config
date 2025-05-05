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
  drivers.intel.enable = true;
  vm.guest-services.enable = false;
}
