{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./../../modules/lang-indicator.nix
    ./../../modules/hardware-aliases.nix
  ];
  boot.blacklistedKernelModules = [ "ucsi_acpi" ];
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  services.hardwareAliases = {
    enable = true;
    keyboardLightID = "asus::kbd_backlight";
    screenOffLightID = "asus::camera";
    touchpadDeviceID = "asue120b:00-04f3:31c0-touchpad";
  };
  services.langIndicator = {
    enable = true;
    lightID = "platform::micmute";
  };

  # AMD has better battery life with PPD over TLP:
  # https://community.frame.work/t/responded-amd-7040-sleep-states/38101/13
  # services.power-profiles-daemon.enable = true;

  # This from can fix some issues especially xserver
  # systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  # services.xserver.videoDrivers = [
  # "amdgpu"
  # ];
}
