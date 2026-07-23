{
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
