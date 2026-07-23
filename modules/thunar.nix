{ pkgs, ... }:
{
  services.gvfs.enable = true;
  programs.dconf.enable = true; # Add so thunar can see syspkgs
  services.tumbler.enable = true;  # Thumbnail support for images
  environment.systemPackages = [ pkgs.file-roller ]; # Archive manager
  xdg.mime.defaultApplications = {
    "inode/directory" = "thunar.desktop";
    "application/zip" = "org.gnome.FileRoller.desktop";
    "application/x-tar" = "org.gnome.FileRoller.desktop";
    "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
  };
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-vcs-plugin
      thunar-volman
    ];
  }; # File manager
}
