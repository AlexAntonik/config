{
  boot = {
    kernelParams = [
      "usbcore.autosuspend=-1"
      "consoleblank=300" # TUI greetd display timeout
    ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}
