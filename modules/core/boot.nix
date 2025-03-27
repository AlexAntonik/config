{ pkgs, config, ... }:

{
  #start speedup
  systemd.services.NetworkManager-wait-online.enable = false;
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    kernelParams = [
      "usbcore.autosuspend=-1"
    ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    # Uncomment for fancy startup loading animation
    # plymouth.enable = true;
    # plymouth.themePackages = [
      # pkgs.adi1090x-plymouth-themes
    # ];
    # plymouth.theme = "rings";
  };
}
