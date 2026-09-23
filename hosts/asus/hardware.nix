{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./../../modules/lang-indicator.nix
    ./../../modules/kbd-backlight.nix
    ./../../modules/scripts/toggleTouchpad.nix
  ];
  boot.blacklistedKernelModules = [ "ucsi_acpi" ];
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  services.kbdBacklight = {
    enable = true;
    idleTimeout = "120";
    keyboardLightID = "asus::kbd_backlight";
    mainMonitor = "eDP-1";
    screenOffLightID = "asus::camera";
  };
  services.langIndicator = {
    enable = true;
    lightID = "platform::micmute";
  };
  programs.touchpadToggle = {
    enable = true;
    deviceID = "asue120b:00-04f3:31c0-touchpad";
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
