{
  # Appimage Support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  
  xdg.portal = {
    enable = true;
  };
  services = {
    libinput.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
  };
}
