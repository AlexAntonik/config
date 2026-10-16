{ lib, ... }:
{
  zramSwap = {
    enable = lib.mkDefault true;
    algorithm = lib.mkDefault "zstd";
    memoryPercent = lib.mkDefault 50;
    priority = lib.mkDefault 5; # must be higher than any disk swap
  };

  # Userspace
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeMemKillThreshold = 2;
    freeSwapThreshold = 10;
    freeSwapKillThreshold = 5;
  };

  systemd.oomd = {
    enableRootSlice = true;
    enableSystemSlice = true;
    enableUserSlices = true;
  };

  boot.kernel.sysctl = {
    "vm.page-cluster" = 1;

    "vm.watermark_scale_factor" = 50;
  };
}
