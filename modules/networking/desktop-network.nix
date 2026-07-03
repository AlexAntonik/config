{
  imports = [ ./base-network.nix ];
  networking.networkmanager.wifi.powersave = false;
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
}
