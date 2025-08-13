{ config, ... }:

{
  #start speedup
  systemd.services.NetworkManager-wait-online.enable = false;
  #Disable hibernation or sleep cause hibernation brakes bt driver
  systemd = {
    targets = {
      sleep = {
        enable = false;
        unitConfig.DefaultDependencies = "no";
      };
      suspend = {
        enable = false;
        unitConfig.DefaultDependencies = "no";
      };
      hibernate = {
        enable = false;
        unitConfig.DefaultDependencies = "no";
      };
      "hybrid-sleep" = {
        enable = false;
        unitConfig.DefaultDependencies = "no";
      };
    };
  };

  boot = {
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "v4l2loopback" ];

    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    kernelParams = [
      "usbcore.autosuspend=-1"
      "consoleblank=300"  #TUI greetd display timeout
    ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}
