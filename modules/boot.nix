{
  # Boot and kernel configuration
  # Note: sleep/suspend/hibernate are disabled as they can break Bluetooth
  
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
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    kernelParams = [
      "usbcore.autosuspend=-1"
      "consoleblank=300" # TUI greetd display timeout
    ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}
