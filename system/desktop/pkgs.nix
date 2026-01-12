{ pkgs, ... }:
{
  programs = {
    dconf.enable = true; # Configuration editor
    seahorse.enable = true; # Password manager
  };

  environment.systemPackages = with pkgs; [
    appimage-run # Needed for AppImage support
    brightnessctl # For screen brightness control
    cliphist # Clipboard manager
    file-roller # Archive manager
    imv # Image viewer
    libnotify # Notification library (notify-send)
    nwg-displays # configure monitor configs via GUI
    gpu-screen-recorder # needed for noctalia screen recorder plugin
    wtype # typing thing
  ];
}
