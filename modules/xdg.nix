{ pkgs, lib, ... }:
{
  xdg = {
    mime.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = false;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = lib.mkDefault [ "gtk" ];
    };
  };
}
