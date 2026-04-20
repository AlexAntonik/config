{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-vcs-plugin
      thunar-volman
    ];
  }; # File manager
}
