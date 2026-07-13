{
  # Appimage Support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  
  services = {
    libinput.enable = true;
    gnome.gnome-keyring.enable = true;
  };
}
