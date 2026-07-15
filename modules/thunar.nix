{ pkgs, ... }:
{
  services.gvfs.enable = true;
  programs.dconf.enable = true; # Add so thunar can see syspkgs
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-vcs-plugin
      thunar-volman
    ];
  }; # File manager
}
