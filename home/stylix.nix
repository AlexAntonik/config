{ ... }:
{
  #home manager targets
  stylix.targets = {
    kitty.enable = false;
    bat.enable = false;
    waybar.enable = false;
    rofi.enable = false;
    btop.enable = false;
    hyprland.enable = false;
    hyprlock.enable = false;
    yazi.enable = false;
    qt.enable = false;
    nvf.enable = false;
    starship.enable = false;
    firefox.enable = false; # for some reason causes cpu freq cap
    #Even i don't have mako installed this fixes stylix shit
    mako.enable = false;
    
    ghostty.enable = false;
  };
}
