{
  inputs,
  ...
}:
{
  imports = [
    # ===========================
    # HARDWARE CONFIGURATION
    # ===========================
    #
    # 1. If your device is listed in nixos-hardware,
    #    just import the corresponding module below.
    #    See: https://github.com/NixOS/nixos-hardware/tree/master
    #
    #    Example (replace 'your-hardware-module'):
    #    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
    #
    #    If you use this, you usually don't need to import anything else here.
    inputs.nixos-hardware.nixosModules.your-hardware-module

    # 2. If your device is not listed, import modules for your CPU/GPU/etc.
    #    Uncomment what you need. You can find examples in the nixos-hardware repo.
    #    Try to match your hardware as closely as possible.
    #
    #    Most common modules:
    #    (uncomment as needed)
    #    inputs.nixos-hardware.nixosModules.common-cpu-amd             # AMD CPUs (generic)
    #    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate      # AMD CPUs pstate driver
    #    inputs.nixos-hardware.common-cpu-amd-zenpower                 # AMD ZenPower sensor
    #    inputs.nixos-hardware.common-cpu-amd-raphael-igpu             # AMD Raphael iGPU
    #    inputs.nixos-hardware.common-cpu-intel                        # Intel CPUs (generic)
    #    inputs.nixos-hardware.common-cpu-intel-cpu-only               # Intel CPUs (CPU only, no iGPU)
    #    inputs.nixos-hardware.nixosModules.common-gpu-amd             # AMD GPUs (generic)
    #    inputs.nixos-hardware.common-gpu-amd-sea-islands              # AMD Sea Islands GPUs
    #    inputs.nixos-hardware.common-gpu-amd-southern-islands         # AMD Southern Islands GPUs
    #    inputs.nixos-hardware.common-gpu-intel                        # Intel integrated GPUs
    #    inputs.nixos-hardware.common-gpu-intel-disable                # Disable Intel GPU
    #    inputs.nixos-hardware.common-gpu-nvidia                       # NVIDIA GPUs (generic)
    #    inputs.nixos-hardware.common-gpu-nvidia-sync                  # NVIDIA Sync
    #    inputs.nixos-hardware.common-gpu-nvidia-nonprime              # NVIDIA non-Prime
    #    inputs.nixos-hardware.common-gpu-nvidia-disable               # Disable NVIDIA GPU
    #    inputs.nixos-hardware.common-hidpi                            # HiDPI display tweaks
    #    inputs.nixos-hardware.common-pc                               # Generic PC hardware
    #    inputs.nixos-hardware.common-pc-hdd                           # PC with HDD
    #    inputs.nixos-hardware.nixosModules.common-pc-laptop           # Generic laptop
    #    inputs.nixos-hardware.common-pc-laptop-acpi_call              # Laptop ACPI call support
    #    inputs.nixos-hardware.common-pc-laptop-hdd                    # Laptop with HDD
    #    inputs.nixos-hardware.common-pc-laptop-ssd                    # Laptop with SSD
    #    inputs.nixos-hardware.nixosModules.common-pc-ssd              # PC with SSD
  ];

  # ===========================
  # ADDITIONAL HARDWARE CONFIG
  # ===========================
  #
  # Sometimes you need extra configuration for your hardware.
  # Look for similar hardware in nixos-hardware for examples.
  #
  # Example: NVIDIA PRIME setup (uncomment and adjust as needed)
  #
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

  # Example: Fix for some ROCm/X server issues
  # systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  # services.xserver.videoDrivers = [
  #   "amdgpu"
  # ];
}
