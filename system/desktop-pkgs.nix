{ pkgs, ... }:
{
  programs = {
    dconf.enable = true; # Configuration editor
    seahorse.enable = true; # Password manager
  };

  environment.systemPackages = with pkgs; [
    appimage-run # Needed for AppImage support
    brightnessctl # For screen brightness control
    cliphist # Clipboard manager using rofi menu
    file-roller # Archive manager
    imv # Image viewer
    libnotify # Notification library
    nwg-displays # configure monitor configs via GUI
    wtype # typing thing
  ];
}
