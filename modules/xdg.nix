{ pkgs, lib, ... }:
{
  home.xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk # GTK fallback
      ];
      config.common.default = lib.mkDefault [ "gtk" ];
    };
  };
}
