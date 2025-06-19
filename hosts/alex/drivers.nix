{
  inputs,
  ...
}:
{
  imports = [
    # If you can find your hardware in the nixos-hardware
    # https://github.com/NixOS/nixos-hardware/tree/master
    # just this import would be enough for whole this file


    # inputs.nixos-hardware.nixosModules.dell-xps-13-9380



    # In other case you need import your hardware by modules
    # uncomment that you need, you can find some
    # examples in above linked repository
    # just find config for pc with same cpu/gpu

    # Most common modules are:

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    # inputs.nixos-hardware.common-cpu-amd-zenpower
    # inputs.nixos-hardware.common-cpu-amd-raphael-igpu
    # inputs.nixos-hardware.common-cpu-intel
    # inputs.nixos-hardware.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    # inputs.nixos-hardware.common-gpu-amd-sea-islands
    # inputs.nixos-hardware.common-gpu-amd-southern-islands
    # inputs.nixos-hardware.common-gpu-intel
    # inputs.nixos-hardware.common-gpu-intel-disable
    # inputs.nixos-hardware.common-gpu-nvidia
    # inputs.nixos-hardware.common-gpu-nvidia-sync
    # inputs.nixos-hardware.common-gpu-nvidia-nonprime
    # inputs.nixos-hardware.common-gpu-nvidia-disable
    # inputs.nixos-hardware.common-hidpi
    # inputs.nixos-hardware.common-pc
    # inputs.nixos-hardware.common-pc-hdd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    # inputs.nixos-hardware.common-pc-laptop-acpi_call
    # inputs.nixos-hardware.common-pc-laptop-hdd
    # inputs.nixos-hardware.common-pc-laptop-ssd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  # In some cases you may need to
  # add some additional hardware configurations
  # for examples find similar hardware in
  # nixos-hardware repository

  # Here nvidia prime configuration
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

  # This from can fix some issues especially xserver
  # systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  # services.xserver.videoDrivers = [
  # "amdgpu"
  # ];
}
