{ pkgs, ... }:
{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs = {
    seahorse.enable = true; # Password manager
  };

  environment.systemPackages = with pkgs; [
    brightnessctl # For screen brightness control
    cliphist # Clipboard manager
    libnotify # Notification library (notify-send)
    nwg-displays # configure monitor configs via GUI
    gpu-screen-recorder # needed for noctalia screen recorder plugin
    wtype # typing thing
  ];
}
