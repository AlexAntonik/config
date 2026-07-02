{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
  boot.blacklistedKernelModules = [ "ucsi_acpi" ];

  # AMD has better battery life with PPD over TLP:
  # https://community.frame.work/t/responded-amd-7040-sleep-states/38101/13
  # services.power-profiles-daemon.enable = true;
  # with tlp laptop is hotter, idk why
  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_AC = "powersave";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "power";

  #     # CPU_MIN_PERF_ON_AC = 0;
  #     # CPU_MAX_PERF_ON_AC = 75;
  #     # CPU_MIN_PERF_ON_BAT = 0;
  #     # CPU_MAX_PERF_ON_BAT = 30;

  #     #Optional helps save long term battery health
  #     START_CHARGE_THRESH_BAT0 = 50; # 40 and below it starts to charge
  #     STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

  #   };
  # };

  # This from can fix some issues especially xserver
  # systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  # services.xserver.videoDrivers = [
  # "amdgpu"
  # ];
}
